package com.jarvismedical.share_alipay

import android.content.Context
import android.content.Intent
import androidx.annotation.NonNull
import com.alipay.share.sdk.openapi.*
import com.alipay.share.sdk.openapi.SendMessageToZFB.Req
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import com.alipay.share.sdk.openapi.APAPIFactory
import com.alipay.share.sdk.openapi.IAPApi
import io.flutter.BuildConfig
import com.alipay.share.sdk.openapi.APMediaMessage
import com.alipay.share.sdk.openapi.APTextObject
import androidx.core.content.ContextCompat.startActivity

/** ShareAlipayPlugin */
class ShareAlipayPlugin : FlutterPlugin, MethodCallHandler {

    private lateinit var channel: MethodChannel
    private lateinit var applicationContext: Context

    private var api: IAPApi? = null

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "share_alipay")
        applicationContext = flutterPluginBinding.applicationContext
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        println("call.method==${call.method}")
        when (call.method) {
            "registerApi" -> {
                try {
                    val registerAP = registerAP(call)
                    result.success(registerAP)
                } catch (e: Exception) {
                    if (BuildConfig.DEBUG) {
                        print("registerApi失败=$e")
                    }
                    result.error("-1", e.message, e)
                }
            }
            "isAppInstalled" -> {
                try {
                    val registerAP = isAppInstalled()
                    result.success(registerAP)
                } catch (e: Exception) {
                    if (BuildConfig.DEBUG) {
                        print("isAppInstalled失败=$e")
                    }
                    result.error("-1", e.message, e)
                }
            }
            "shareText" -> {
                try {
                    val registerAP = shareText(call)
                    result.success(registerAP)
                } catch (e: Exception) {
                    if (BuildConfig.DEBUG) {
                        print("shareText失败=$e")
                    }
                    result.error("-1", e.message, e)
                }
            }
            "shareImageData" -> {
                try {
                    val registerAP = shareImageData(call)
                    result.success(registerAP)
                } catch (e: Exception) {
                    if (BuildConfig.DEBUG) {
                        print("shareImageData失败=$e")
                    }
                    result.error("-1", e.message, e)
                }
            }
            "shareImageUrl" -> {
                try {
                    val registerAP = shareImageUrl(call)
                    result.success(registerAP)
                } catch (e: Exception) {
                    if (BuildConfig.DEBUG) {
                        print("shareImageUrl失败=$e")
                    }
                    result.error("-1", e.message, e)
                }
            }
            "shareWebUrl", "shareWebData" -> {
                try {
                    val registerAP = shareWebPage(call)
                    result.success(registerAP)
                } catch (e: Exception) {
                    if (BuildConfig.DEBUG) {
                        print("shareWebUrl、shareWebData失败=$e")
                    }
                    result.error("-1", e.message, e)
                }
            }
            else -> result.notImplemented()

        }
    }


    /**
     *
     * 注册支付宝
     *  检查当前手机上安装的支付宝版本是否支持分享到朋友
     * @param call MethodCall
     * @return Boolean
     *
     */
    private fun registerAP(call: MethodCall): Boolean {
        val appId = call.argument<String>("appId")
        print("支付宝分享appId=$appId")
        api = APAPIFactory.createZFBApi(applicationContext, appId, false)
        val support = api?.isZFBSupportAPI ?: false
        if (BuildConfig.DEBUG) {
            print("支付宝分享isSupport=$support")
        }
        return support
    }

    /**
     *  是否安装支付宝
     * @return Boolean
     */
    private fun isAppInstalled(): Boolean {
        val isInstalled: Boolean = api?.isZFBAppInstalled ?: false
        if (BuildConfig.DEBUG) {
            print("是否安装支付宝:$isInstalled")
        }

        val shareIntent = Intent()
        shareIntent.setAction(Intent.ACTION_SEND)
        shareIntent.putExtra(Intent.EXTRA_TEXT, "text")
        shareIntent.putExtra(Intent.EXTRA_SUBJECT, "subject")
        shareIntent.setType("text/plain")
        val chooserIntent: Intent =
            Intent.createChooser(shareIntent, null /* dialog title optional */)
        chooserIntent.flags = Intent.FLAG_ACTIVITY_NEW_TASK;
        applicationContext.startActivity(chooserIntent)
        return isInstalled
    }


    /**
     * 分享文本信息
     * @param call MethodCall
     * @return Boolean
     *  传参"text":String
     */
    private fun shareText(call: MethodCall): Boolean {
//        //初始化一个APTextObject对象
        val textObject = APTextObject()
        textObject.text = call.argument("text")
        //组装分享消息对象
        val mediaMessage = APMediaMessage()
        mediaMessage.mediaObject = textObject
        //将分享消息对象包装成请求对象
        val req = Req()
        req.message = mediaMessage
        //发送请求
        return api?.sendReq(req) ?: false
    }

    /**
     * 分享图片数据
     * @param call MethodCall
     * @return Boolean
     *  传参"imageData":ByteArray
     */
    private fun shareImageData(call: MethodCall): Boolean {
        val imageByte = call.argument<ByteArray>("imageData")
        val imageObject = APImageObject()
        imageObject.imageData = imageByte
        val mediaMessage = APMediaMessage()
        // 图片二进制流分享
        mediaMessage.mediaObject = imageObject
        val req = Req()
        req.message = mediaMessage
        req.transaction = buildTransaction("image")
        //调用api接口发送消息到支付宝
        return api?.sendReq(req) ?: false
    }

    /**
     * 分享图片url
     * @param call MethodCall
     * @return Boolean
     *  传参"imageUrl":String
     */
    private fun shareImageUrl(call: MethodCall): Boolean {
        val imageObject = APImageObject()
        imageObject.imageUrl = call.argument("imageUrl")
        val mediaMessage = APMediaMessage()
        mediaMessage.mediaObject = imageObject
        val req = Req()
        req.message = mediaMessage
        req.transaction = buildTransaction("image")
        //调用api接口发送消息到支付宝
        return api?.sendReq(req) ?: false
    }

    /**
     * 分享图片url
     * @param call MethodCall
     * @return Boolean
     * 网页缩略图的分享支持bitmap和url两种方式，直接通过bitmap传递时bitmap最大为32K
     *  传参"webpageUrl":String
     *  传参"title":String
     *  传参"desc":String
     */
    private fun shareWebPage(call: MethodCall): Boolean {
        val webPageObject = APWebPageObject()
        webPageObject.webpageUrl = call.argument("webpageUrl")
        val webMessage = APMediaMessage()
        webMessage.title = call.argument("title")
        webMessage.description = call.argument("desc")
        webMessage.mediaObject = webPageObject
        if (call.method == "shareWebData") {
            webMessage.thumbData = call.argument("imageData")
        } else {
            webMessage.thumbUrl = call.argument("imageUrl")
        }
        val webReq = Req()
        webReq.message = webMessage
        webReq.transaction = buildTransaction("webpage")
        //调用api接口发送消息到支付宝
        return api?.sendReq(webReq) ?: false
    }


    private fun buildTransaction(type: String?): String {
        return "${type ?: "ImageShare"}${System.currentTimeMillis()}"
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }


}
