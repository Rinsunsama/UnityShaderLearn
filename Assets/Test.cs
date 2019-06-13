using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Test : MonoBehaviour {

	// Use this for initialization
	void Start () {

	}
	
	// Update is called once per frame
	void Update () {
        GetComponent<SkinnedMeshRenderer>().material.SetFloat("_Disffuse_Amount", 0.998f);
    }
}
