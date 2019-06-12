Shader "__MyShader__/MergaShader" {
	Properties
	{
		_TintColor("Color",Color) = (1,1,1,1)
		[Header(Color Ramp Sample)]
		[NoScaleOffset]_MainTexture("MainTexture",2D) = "grey"{}
		_SecondTexture("SecondTexture",2D) = "grey"{}
		_Blend_Amount("_Blend_Amount",Range(0,1)) = 0
	}
	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
		}

		pass
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			//step1
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv0 : TEXCOORD1;
			//	float2 uv1 : TEXCOORD0;
			};

			//step 3
			struct v2f{
				float4 position : SV_POSITION;
				float2 uv0 : TEXCOORD1;
			//	float2 uv1 : TEXCOORD0;
			};

			float4 _TintColor;
			sampler2D _MainTexture;
			sampler2D _SecondTexture;
			float _Blend_Amount;

			v2f vert(appdata IN)
			{
				v2f OUT;
				//IN.vertex.xyz *= sin(_Time.y * _Modifier)/2 + 0.5f;
				OUT.position = UnityObjectToClipPos(IN.vertex);
				OUT.uv0 = IN.uv0;
				return OUT;
			}

			fixed4 frag(v2f IN) : SV_Target
			{
				
				//return _TintColor;
				float4 mainColor = tex2D(_MainTexture,IN.uv0);
				float4 subColor = tex2D(_SecondTexture,IN.uv0);
				return lerp(mainColor,subColor,_Blend_Amount);
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}
