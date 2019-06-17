Shader "__MyShader__/OverDraw" {

	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"			//非透明渲染
		}

		ZTest Always
		ZWrite Off
		Blend One One

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
			};

			//step 3
			struct v2f{
				float4 vertex : SV_POSITION;
			};


			v2f vert(appdata IN)
			{
				v2f OUT;
				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				return OUT;
			}

			fixed4 _OverDraw;

			fixed4 frag(v2f IN) : SV_Target
			{
				return _OverDraw;
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}
