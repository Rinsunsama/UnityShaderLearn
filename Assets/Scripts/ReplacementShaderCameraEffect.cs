﻿using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ReplacementShaderCameraEffect : MonoBehaviour {

    public Shader ReplacementShader;

    private void OnEnable()
    {
        if (ReplacementShader != null)
        {
            GetComponent<Camera>().SetReplacementShader(ReplacementShader, "RendType");
        }
    }

    private void OnDisable()
    {
        GetComponent<Camera>().ResetReplacementShader();
    }

}