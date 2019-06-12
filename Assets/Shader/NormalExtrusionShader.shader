Shader "__MyShader__/NormalExtrusionShader" {
	Properties
	{
		_TintColor("Color",Color) = (1,1,1,1)
		[Header(Color Ramp Sample)]
		[NoScaleOffset]_MainTexture("MainTexture",2D) = "grey"{}
		_Extrusion_Amount("Extrusion Amount",Range(-10,10)) = 0
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
				float3 normal : NORMAL;
			};

			//step 3
			struct v2f{
				float4 vertex : SV_POSITION;
				float2 uv0 : TEXCOORD1;
				float3 color: COLOR;
			};

			float4 _TintColor;
			sampler2D _MainTexture;
			float _Extrusion_Amount;

			v2f vert(appdata IN)
			{
				v2f OUT;
				IN.vertex.z += IN.normal.z*_Extrusion_Amount;
				OUT.vertex = UnityObjectToClipPos(IN.vertex);

				OUT.uv0 = IN.uv0;
				OUT.color = normalize(IN.normal);
				return OUT;
			}

			fixed4 frag(v2f IN) : SV_Target
			{
				//return _TintColor;
				float4 mainColor = tex2D(_MainTexture,IN.uv0);
				return fixed4(IN.color,1);
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}
