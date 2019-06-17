using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode]
public class ReplacementShaderCameraEffect : MonoBehaviour {

    public Shader ReplacementShader;
    public Color overDrawColor;
    void OnValidate()
    {
        Shader.SetGlobalColor("_OverDraw", overDrawColor);
    }

    private void OnEnable()
    {
        if (ReplacementShader != null)
        {
            GetComponent<Camera>().SetReplacementShader(ReplacementShader, "");
        }
    }

    private void OnDisable()
    {
        GetComponent<Camera>().ResetReplacementShader();
    }

}
