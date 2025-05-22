package com.dartCoder.mobile_number_picker

import android.app.Activity
import android.app.Activity.RESULT_OK
import android.app.PendingIntent
import android.content.Intent
import androidx.core.app.ActivityCompat
import com.google.android.gms.auth.api.identity.GetPhoneNumberHintIntentRequest
import com.google.android.gms.auth.api.identity.Identity
import io.flutter.embedding.android.FlutterFragmentActivity
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.ActivityResultListener

/** MobileNumberPickerPlugin */
class MobileNumberPickerPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    ActivityResultListener {

    companion object {
        private const val TAG = "PHONE_NUMBER_PICKER"
        private const val PHONE_HINT_REQUEST = 10001
    }

    private lateinit var channel: MethodChannel
    private lateinit var phoneNumberHintRequest: GetPhoneNumberHintIntentRequest
    private var mActivity: Activity? = null
    private var pendingResult: Result? = null

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "mobile_number_picker")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        pendingResult = result
        when (call.method) {
            "getMobileNumbers" -> {
                if (mActivity == null) {
                    return
                }
                phoneNumberHintRequest = GetPhoneNumberHintIntentRequest.builder().build()
                val request: GetPhoneNumberHintIntentRequest =
                    GetPhoneNumberHintIntentRequest.builder().build()
                Identity.getSignInClient(mActivity!!).getPhoneNumberHintIntent(request)
                    .addOnSuccessListener { intentResult: PendingIntent ->
                        try {
                            ActivityCompat.startIntentSenderForResult(
                                mActivity!!,
                                intentResult.intentSender,
                                PHONE_HINT_REQUEST,
                                null,
                                0,
                                0,
                                0,
                                null
                            )
                        } catch (e: Exception) {
                            e.printStackTrace()
                        }
                    }.addOnFailureListener {
                        pendingResult?.success("{\"code\": 503, \"errorMessage\": \"PHONE HINT FAILED. $TAG: ${it.message}\"}")
                    }
                return
            }
        }

    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        mActivity = binding.activity as FlutterFragmentActivity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivityForConfigChanges() {
        mActivity = null
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        mActivity = binding.activity as FlutterFragmentActivity
        binding.addActivityResultListener(this)
    }

    override fun onDetachedFromActivity() {
        mActivity = null
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?): Boolean {
        when (requestCode) {
            PHONE_HINT_REQUEST -> {
                parseHintRequest(resultCode, data)
            }
        }
        return true
    }

    private fun parseHintRequest(resultCode: Int, data: Intent?) {
        try {
            if (resultCode == RESULT_OK && data != null) {
                val phoneNumber =
                    Identity.getSignInClient(mActivity!!).getPhoneNumberFromIntent(data)
                pendingResult?.success("{\"code\": 200, \"data\": \"$phoneNumber\"}")
            } else if (resultCode == Activity.RESULT_CANCELED) {
                pendingResult?.success("{\"code\": 499, \"errorMessage\": \"$TAG: PROCESS CANCELLED BY USER\"}")
            }
        } catch (e: Exception) {
            e.printStackTrace()
        }
    }
}
