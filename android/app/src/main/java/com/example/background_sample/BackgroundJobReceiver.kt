package com.example.background_sample

import android.app.AlarmManager
import android.app.PendingIntent
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import ss_n.common_ktx.extension.getAlarmManager

class BackgroundJobReceiver : BroadcastReceiver() {

    override fun onReceive(context: Context, intent: Intent) {
        val methodName = intent.getStringExtra(MyCoroutineWorker.KEY_METHOD_NAME)
        val interval = intent.getIntExtra(KEY_INTERVAL, DEFAULT_INTERVAL)

        MyCoroutineWorker.startOneTimeWorker(context, methodName)

        setBackgroundJob(context, methodName, interval)
    }

    companion object {
        const val KEY_INTERVAL = "interval"
        const val DEFAULT_INTERVAL = 15

        fun setBackgroundJob(context: Context, methodName: String?, interval: Int) {
            val manager = context.getAlarmManager()
            val pendingIntent = createBackgroundJobIntent(context, methodName, interval)

            manager.setExactAndAllowWhileIdle(AlarmManager.RTC, interval.toDatePlusMinute().time, pendingIntent)
        }

        fun clearBackgroundJob(context: Context) {
            val manager = context.getAlarmManager()
            val pendingIntent = createBackgroundJobIntent(context)
            manager.cancel(pendingIntent)
        }

        private fun createBackgroundJobIntent(context: Context, methodName: String? = null, interval: Int = 15): PendingIntent {
            val intent = Intent(context, BackgroundJobReceiver::class.java).apply {
                putExtra(MyCoroutineWorker.KEY_METHOD_NAME, methodName)
                putExtra(KEY_INTERVAL, interval)
            }
            return PendingIntent.getBroadcast(context, 0, intent, PendingIntent.FLAG_UPDATE_CURRENT)
        }
    }
}