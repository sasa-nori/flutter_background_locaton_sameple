package com.example.background_sample

import android.annotation.SuppressLint
import android.content.Context
import android.util.Log
import androidx.work.CoroutineWorker
import androidx.work.ExistingPeriodicWorkPolicy
import androidx.work.OneTimeWorkRequest
import androidx.work.OneTimeWorkRequestBuilder
import androidx.work.PeriodicWorkRequest
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import androidx.work.WorkerParameters
import androidx.work.workDataOf
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.TimeUnit
import kotlin.coroutines.resume
import kotlin.coroutines.suspendCoroutine
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.runBlocking


class MyCoroutineWorker(applicationContext: Context,
                        private val params: WorkerParameters
) : CoroutineWorker(applicationContext, params) {

    private val methodName
        get() = params.inputData.getString(KEY_METHOD_NAME) ?: ""

    @SuppressLint("MissingPermission")
    override suspend fun doWork(): Result {
        if (!applicationContext.isActiveNetwork()) return Result.retry()
        return suspendCoroutine<Result> {
            val callback = object : MethodChannel.Result {
                override fun success(result: Any?) {
                    // Timberとか入れてもいいかも
                    Log.d(methodName, "Success")

                    it.resume(Result.success())
                }

                override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
                    Log.d(methodName, "Error")

                    it.resume(Result.failure())
                }

                override fun notImplemented() {
                    Log.d(methodName, "notImplemented")
                    it.resume(Result.failure())
                }
            }
            // MainThread指定しないとだめ
            runBlocking(Dispatchers.Main) {
                MyApplication.flutterEngine?.let { engine ->
                    val channel = MethodChannel(engine.dartExecutor.binaryMessenger, MainActivity.CHANNEL)
                    channel.invokeMethod(methodName, null, callback)
                }
            }
            return@suspendCoroutine
        }
    }

    companion object {
        const val KEY_METHOD_NAME = "methodName"
        const val KEY_MINUTES = "minutes"
        private const val TAG_MY_WORKER = "myWorker"

        fun startOneTimeWorker(applicationContext: Context, methodName: String?) {
            val worker: OneTimeWorkRequest = OneTimeWorkRequestBuilder<MyCoroutineWorker>()
                    .setInputData(workDataOf(
                            KEY_METHOD_NAME to methodName
                    ))
                    .build()
            createWorkerInstance(applicationContext).enqueue(worker)
        }

        fun startRepeatWorker(applicationContext: Context, methodName: String?, interval: Long?) {
            val worker: PeriodicWorkRequest = PeriodicWorkRequestBuilder<MyCoroutineWorker>(interval
                    ?: 15, TimeUnit.MINUTES)
                    .setInputData(workDataOf(
                            KEY_METHOD_NAME to methodName
                    ))
                    .build()
            createWorkerInstance(applicationContext).enqueueUniquePeriodicWork(
                    TAG_MY_WORKER,
                    ExistingPeriodicWorkPolicy.KEEP,
                    worker
            )
        }

        fun cancelWorker(applicationContext: Context) {
            val workManager = createWorkerInstance(applicationContext)
            workManager.cancelUniqueWork(TAG_MY_WORKER)
        }

        private fun createWorkerInstance(applicationContext: Context): WorkManager = WorkManager.getInstance(applicationContext)
    }


}