using UnityEngine;

public class MaterialController : MonoBehaviour
{
    public MeshRenderer meshRenderer;

    [Range(0.1f, 0.5f)] public float bloat = 0;

    // Start is called before the first frame update
    void Start()
    {
        meshRenderer = GetComponent<MeshRenderer>();
    }

    // Update is called once per frame
    void Update()
    {
        meshRenderer.material.SetFloat("_Bloat", bloat);
    }
}
