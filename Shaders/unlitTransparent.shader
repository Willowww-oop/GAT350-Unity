Shader "GAT350/unlitTransparent"
{
    Properties
    {
        [Header(Shader info)]
        [Space(20)]
        [Toggle] _Active ("Active", int) = 1

        _MainTex ("Texture", 2D) = "white" {}
        _Transparency ("Transparency", Range(0.0, 1.0)) = 1.0
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Opaque" }
        LOD 100

        Blend SrcAlpha OneMinusSrcAlpha
        ZWrite Off

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            // make fog work
            #pragma multi_compile_fog

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                UNITY_FOG_COORDS(1)
                float4 vertex : SV_POSITION;
            };

            // Texutre 1

            sampler2D _MainTex;
            float4 _MainTex_ST;
            float _Transparency;
            int _Active;

            v2f vert (appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = TRANSFORM_TEX(v.uv, _MainTex);
                UNITY_TRANSFER_FOG(o,o.vertex);
                return o;
            }

            fixed4 frag (v2f i) : SV_Target
            {
                // sample the texture
                fixed4 color = tex2D(_MainTex, i.uv);
                color.a = _Transparency;


                // apply fog

                UNITY_APPLY_FOG(i.fogCoord, color);
                return color;
            }
            ENDCG
        }   
    }
}
