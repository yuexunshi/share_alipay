package com.jarvismedical.share_alipay_example

import android.os.Bundle
import android.os.PersistableBundle
import com.alipay.share.sdk.openapi.APAPIFactory
import com.alipay.share.sdk.openapi.BaseReq
import com.alipay.share.sdk.openapi.BaseResp
import com.alipay.share.sdk.openapi.IAPAPIEventHandler
import io.flutter.embedding.android.FlutterActivity

class MainActivity : FlutterActivity(), IAPAPIEventHandler {


    override fun onCreate(savedInstanceState: Bundle?, persistentState: PersistableBundle?) {
        super.onCreate(savedInstanceState, persistentState)
        println("======MainActivity.onCreate")
        val createZFBApi = APAPIFactory.createZFBApi(applicationContext, "2021002189602304", false)
        createZFBApi.handleIntent(intent, this)
    }

    override fun onResume() {
        super.onResume()
        println("=====MainActivity.onResume")
    }

    override fun onDestroy() {
        super.onDestroy()
        println("=====MainActivity.onDestroy")
    }

    override fun onReq(p0: BaseReq?) {
        println("============MainActivity.onReq==p0=$p0")
    }

    override fun onResp(baseResp: BaseResp) {
        val result = when (baseResp.errCode) {
            BaseResp.ErrCode.ERR_OK -> R.string.errcode_success
            BaseResp.ErrCode.ERR_USER_CANCEL -> R.string.errcode_cancel
            BaseResp.ErrCode.ERR_AUTH_DENIED -> R.string.errcode_deny
            BaseResp.ErrCode.ERR_SENT_FAILED -> R.string.errcode_send_fail
            else -> R.string.errcode_unknown
        }
        println("baseResp =========result=$result==== [${baseResp}]")
    }
}
