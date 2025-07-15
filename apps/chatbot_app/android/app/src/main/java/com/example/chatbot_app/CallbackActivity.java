package com.example.chatbot_app;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;

public class CallbackActivity extends Activity {
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Intent intent = new Intent(this, MainActivity.class);
        intent.setAction(getIntent().getAction());
        intent.setData(getIntent().getData());
        intent.putExtras(getIntent());
        startActivity(intent);
        finish();
    }
}
