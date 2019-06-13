Shader "__MyShader__/WaveShader" {
	Properties
	{
		[NoScaleOffset]_MainTexture("MainTexture",2D) = "grey"{}
		_Speed("Speed",float) = 1.0
		_Distance("Distance",float) = 1.0
		_Frequency("Frequency",float) = 1.0
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
				//float3 color: COLOR;
			};

			sampler2D _MainTexture;
			float _Speed;
			float _Distance;
			float _Frequency;

			v2f vert(appdata IN)
			{
				v2f OUT;
				float waveTime = _Time.y * _Speed;
				float waveRipples = IN.vertex.x * _Frequency;
				IN.vertex.y += sin(waveTime + waveRipples) * _Distance;
				OUT.vertex = UnityObjectToClipPos(IN.vertex);

				OUT.uv0 = IN.uv0;
				//OUT.color = normalize(IN.normal);
				return OUT;
			}

			fixed4 frag(v2f IN) : SV_Target
			{
				//return _TintColor;
				float4 mainColor = tex2D(_MainTexture,IN.uv0);
				return mainColor;
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}
