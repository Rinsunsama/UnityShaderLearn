Shader "__MyShader__/DiffuseLightingShader" {
	Properties
	{
		[NoScaleOffset]_MainTexture("MainTexture",2D) = "grey"{}
		_Disffuse_Amount("Dissfuse Amount",Range(0,1)) = 0
	}
	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"
			"LightMode" = "ForwardBase"
		}

		pass
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"
			#include "UnityLightingCOmmon.cginc"

			//step1
			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv0 : TEXCOORD1;
				float3 normal : NORMAL;
			};

			//step 3
			struct v2f{
				float4 vertex : SV_POSITION;
				float2 uv0 : TEXCOORD1;
				float3 normal : NORMAL;
			};

			sampler2D _MainTexture;
			float _Disffuse_Amount;

			v2f vert(appdata IN)
			{
				v2f OUT;
				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				OUT.normal =  UnityObjectToWorldNormal(IN.normal);
				OUT.uv0 = IN.uv0;
				//OUT.color = normalize(IN.normal);
				return OUT;
			}

			fixed4 frag(v2f IN) : SV_Target
			{
				//return _TintColor;
				float nDot =  dot(IN.normal,_WorldSpaceLightPos0.xyz)*(1-_Disffuse_Amount) + _Disffuse_Amount;
				fixed3 disffuseColor = (nDot * _LightColor0);
				float4 mainColor = tex2D(_MainTexture,IN.uv0);
				return fixed4(mainColor * disffuseColor,1);
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}
