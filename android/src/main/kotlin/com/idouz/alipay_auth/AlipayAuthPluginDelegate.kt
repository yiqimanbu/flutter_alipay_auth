package com.idouz.alipay_auth

import android.app.Activity
import android.content.Context
import android.content.Intent
import android.content.pm.PackageInfo
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Bundle
import android.util.Log
import kotlinx.coroutines.*
import io.flutter.plugin.common.MethodChannel.Result
import com.alipay.sdk.auth.OpenAuthTask
import io.flutter.plugin.common.MethodCall
import java.lang.ref.WeakReference
import javax.security.auth.callback.Callback

class AlipayAuthPluginDelegate {

    lateinit var activity: Activity
    fun handleMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "auth" -> openAuthScheme(call, result)
            "isAliPayInstalled" -> isAliPayInstalled(result)
            else -> result.notImplemented()
        }
    }

    /**
     * 通用跳转授权业务 Demo
     */
    fun openAuthScheme(call: MethodCall, result: Result) {

        // 传递给支付宝应用的业务参数
        val bizParams: MutableMap<String, String> = HashMap()
        //		bizParams.put("url", "alipays://platformapi/startapp?appId=60000157&appClearTop=false&startMultApp=YES&sign_params=biz_content%3D%257B%2522access_params%2522%253A%257B%2522channel%2522%253A%2522ALIPAYAPP%2522%257D%252C%2522external_agreement_no%2522%253A%2522shiyun20191231_08%2522%252C%2522external_logon_id%2522%253A%2522%25E5%25A4%2596%25E9%2583%25A8%25E7%2599%25BB%25E9%2599%2586%25E5%25A5%25BD%2522%252C%2522personal_product_code%2522%253A%2522GENERAL_WITHHOLDING_P%2522%252C%2522sign_scene%2522%253A%2522INDUSTRY%257CMULTI_MEDIA%2522%257D%26sign%3DFIQnneyCyigONOb1vZnBtTF7c80pUiETOvEL4GXbQOJNyysZ0EhjPhT1dGWLgsBYw5nCtKy1nw4Bt2st89LAsq9LB9gQ2%252FiRyYwWvKkfmhIZcMTv9WF198KNOOVhK5BsHlVXA5Q99NnzF5iFdPt7N%252BDpKlraohg8papDgiudimwd1B5ByA0UMWgEJKZxzkOy4m%252F0KGc5I3TuRynp3nbzRoFzrBJuqUzEjLwlDtf1%252Brxl%252BqNBgYvYSNgctm6fyNqP%252Bm%252FDoEYl6Nr9BfAaUyxcD60dBBhKXLqaN3B1fkq7C2p9JygV3IyZDh12bUIC6pAFdbPdYEsh5fVVpEPD79xD5A%253D%253D%26timestamp%3D2020-01-08%2B18%253A08%253A57%26sign_type%3DRSA2%26charset%3DUTF-8%26app_id%3D2017090501336035%26method%3Dalipay.user.agreement.page.sign%26version%3D1.0");
        bizParams["url"] = call.arguments as String

        // 支付宝回跳到你的应用时使用的 Intent Scheme。请设置为不和其它应用冲突的值。
        // 如果不设置，将无法使用 H5 中间页的方法(OpenAuthTask.execute() 的最后一个参数)回跳至
        // 你的应用。
        //
        // 参见 AndroidManifest 中 <AlipayResultActivity> 的 android:scheme，此两处
        // 必须设置为相同的值。
        lateinit var scheme :String

        var manager: PackageManager = activity.getPackageManager()
        try {
            val info: PackageInfo = manager.getPackageInfo(activity.getPackageName(), 0)
            scheme = "__alipay_${info.packageName}__"
            Log.d("TAG", "scheme：$scheme")
        } catch (e: PackageManager.NameNotFoundException) {
            e.printStackTrace()
        }


        // 防止在支付宝 App 被强行退出等情况下，OpenAuthTask.Callback 一定时间内无法释放导致
        // Activity 泄漏。
        val ctxRef: WeakReference<AlipayAuthPluginDelegate> =
            WeakReference<AlipayAuthPluginDelegate>(this)

        // 唤起授权业务
        val task = OpenAuthTask(activity)
        task.execute(
            scheme,  // Intent Scheme
            OpenAuthTask.BizType.AccountAuth,  // 业务类型
            bizParams,  // 业务参数
            object : OpenAuthTask.Callback {
                override fun onResult(i: Int, s: String?, bundle: Bundle?) {
                    val ref: AlipayAuthPluginDelegate? = ctxRef.get()
                    if (ref != null) {
                        Log.e("AlipayAuthPlugin", "onResult: " + bundle.toString())
                        bundle?.let {
                            result.success(toMap(bundle))
                        }

                    }

                }
            },  // 业务结果回调
            true
        ) // 是否需要在用户未安装支付宝 App 时，使用 H5 中间页中转
    }

    private fun isAliPayInstalled(result: Result) {
        val manager = activity?.packageManager
        if (manager != null) {
            val action = Intent(Intent.ACTION_VIEW)
            action.data = Uri.parse("alipays://")
            val list = manager.queryIntentActivities(action, PackageManager.GET_RESOLVED_FILTER)
            result.success(list != null && list.size > 0)
        } else {
            result.error("-1", "can't find packageManager", null)
        }
    }

    private fun toMap(bundle: Bundle): Map<String, String?> {
        var map = mapOf(
            "app_id" to bundle.getString("app_id"),
            "auth_code" to bundle.getString("auth_code"),
            "result_code" to bundle.getString("result_code"),
            "scope" to bundle.getString("scope"),
            "state" to bundle.getString("state"),
            "platform" to "android"
        );
        return map
    }
}