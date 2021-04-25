package com.example.background_sample

import android.annotation.SuppressLint
import android.content.Context
import android.util.Log
import androidx.work.CoroutineWorker
import androidx.work.PeriodicWorkRequestBuilder
import androidx.work.WorkManager
import androidx.work.WorkRequest
import androidx.work.WorkerParameters
import androidx.work.workDataOf
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.concurrent.TimeUnit
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.withContext


class MyCoroutineWorker(applicationContext: Context,
                        private val params: WorkerParameters
) : CoroutineWorker(applicationContext, params) {

    private val flutterEngine
        get() = FlutterEngine(applicationContext)

    private val methodName
        get() = params.inputData.getString(KEY_METHOD_NAME)

    @SuppressLint("MissingPermission")
    override suspend fun doWork(): Result {
        if (!applicationContext.isActiveNetwork()) return Result.retry()
        return withContext(Dispatchers.IO) {
            val channel = MethodChannel(flutterEngine.dartExecutor, MainActivity.CHANNEL)
            channel.invokeMethod(methodName, null, object : MethodChannel.Result {
                override fun success(result: Any?) {
                    // Timberとか入れてもいいかも
                    Log.d(methodName, "Success")
                }

                override fun error(errorCode: String?, errorMessage: String?, errorDetails: Any?) {
                    Log.d(methodName, "Success")
                }

                override fun notImplemented() {
                    throw NotImplementedError()
                }
            })
            return@withContext Result.success()
        }
    }

    companion object {
        const val KEY_METHOD_NAME = "methodName"
        const val KEY_MINUTES = "minutes"
        private const val TAG_MY_WORKER = "myWorker"

        fun startWorker(applicationContext: Context, methodName: String?, interval: Long?) {
            val worker: WorkRequest = PeriodicWorkRequestBuilder<MyCoroutineWorker>(interval
                    ?: 15, TimeUnit.MINUTES)
                    .setInputData(workDataOf(
                            KEY_METHOD_NAME to methodName
                    )).addTag(TAG_MY_WORKER)
                    .build()
            createWorkerInstance(applicationContext).enqueue(worker)
        }

        fun cancelWorker(applicationContext: Context) {
            val workManager = createWorkerInstance(applicationContext)
            workManager.cancelAllWorkByTag(TAG_MY_WORKER)
        }

        private fun createWorkerInstance(applicationContext: Context): WorkManager = WorkManager.getInstance(applicationContext)
    }


}