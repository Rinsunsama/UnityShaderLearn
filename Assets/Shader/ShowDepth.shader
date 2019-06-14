Shader "__MyShader__/ShowDepthShader" {
	Properties
	{
		_Color("Color",color) = (1,1,1,1)
	}
	SubShader
	{
		Tags
		{
			"RenderType" = "Opaque"			//非透明渲染
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
			};

			//step 3
			struct v2f{
				float4 vertex : SV_POSITION;
				float depth : Depth;
			};


			v2f vert(appdata IN)
			{
				v2f OUT;
				OUT.vertex = UnityObjectToClipPos(IN.vertex);
				OUT.depth = -UnityObjectToViewPos(IN.vertex).z * _ProjectionParams.w;
				return OUT;
			}

			fixed _Color;

			fixed4 frag(v2f IN) : SV_Target
			{
				float invert = 1 - IN.depth;
				return fixed4(invert,invert,invert,1);
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}
