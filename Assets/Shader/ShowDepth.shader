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

		ZWrite On
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
				OUT.depth = -UnityObjectToViewPos(IN.vertex).z * _ProjectionParams.w;		//物体视图坐标的z值表示到摄像机的距离 ，_ProjectionParams.w 为视图远切面的距离的倒数
																							//得到depth 是从0-1的深度值，值越小表示距离摄像机越近
				return OUT;
			}

			fixed4 _Color;

			fixed4 frag(v2f IN) : SV_Target
			{
				float invert = 1 - IN.depth;
				return fixed4(invert,invert,invert,1) * _Color;
			}

			ENDCG
		}
	}

	SubShader
	{
		Tags
		{
			"RenderType" = "Transparent"			//非透明渲染
		}

		ZWrite Off
		Blend SrcAlpha OneMinusSrcAlpha

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

			fixed4 _Color;

			fixed4 frag(v2f IN) : SV_Target
			{
				return _Color;
			}

			ENDCG
		}
	}

	FallBack "Diffuse"
}
