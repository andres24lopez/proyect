package com.example.login;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

import androidx.activity.EdgeToEdge;
import androidx.appcompat.app.AlertDialog;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.graphics.Insets;
import androidx.core.view.ViewCompat;
import androidx.core.view.WindowInsetsCompat;

import com.android.volley.RequestQueue;
import com.android.volley.Response;
import com.android.volley.toolbox.Volley;

import org.json.JSONException;
import org.json.JSONObject;

public class Registro extends AppCompatActivity implements View.OnClickListener {

    EditText etnombre,etusuario,etpassword,etedad;
    Button btn_guardar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        EdgeToEdge.enable(this);
        setContentView(R.layout.activity_registro);
        ViewCompat.setOnApplyWindowInsetsListener(findViewById(R.id.main), (v, insets) -> {
            Insets systemBars = insets.getInsets(WindowInsetsCompat.Type.systemBars());
            v.setPadding(systemBars.left, systemBars.top, systemBars.right, systemBars.bottom);













            return insets;
        });
        etnombre= findViewById(R.id.EditT_nombre);
        etusuario=findViewById(R.id.EditT_usuario);
        etpassword=findViewById(R.id.EditT_contraseña);
        etedad=findViewById(R.id.EditT_edad);
        btn_guardar=findViewById(R.id.btn_registrar);

        btn_guardar.setOnClickListener(this);

    }


    @Override
    public void onClick(View view) {
        Toast.makeText(Registro.this, "Botón presionado", Toast.LENGTH_SHORT).show();
        final String name=etnombre.getText().toString();
        final String username=etusuario.getText().toString();
        final int age= Integer.parseInt(etedad.getText().toString());
        final String password=etpassword.getText().toString();


        Response.Listener<String> respoListener =new Response.Listener<String>() {
            @Override
            public void onResponse(String response) {
                try {
                    JSONObject jsonReponse =new JSONObject(response);
                    boolean success=jsonReponse.getBoolean("success");
                    if (success){
                        Intent intent=new Intent(Registro.this,MainActivity.class);
                        Registro.this.startActivity(intent);
                    }else {
                        AlertDialog.Builder builder =new AlertDialog.Builder(Registro.this);
                        builder.setMessage("error registro")
                                .setNegativeButton("retry",null)
                                .create().show();
                    }

                }catch (JSONException e){
                    e.printStackTrace();
                }


            }
        };

        RegisterRequest registerRequest=new RegisterRequest(name,username,age,password,respoListener);
        RequestQueue queue= Volley.newRequestQueue(Registro.this);
        queue.add(registerRequest);
    }
}