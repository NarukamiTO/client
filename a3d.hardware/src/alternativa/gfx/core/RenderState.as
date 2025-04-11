package alternativa.gfx.core {
  import flash.geom.Rectangle;

  public class RenderState {
    public var blendSourceFactor:String = "one";
    public var blendDestinationFactor:String = "zero";
    public var colorMaskRed:Boolean = true;
    public var colorMaskGreen:Boolean = true;
    public var colorMaskBlue:Boolean = true;
    public var colorMaskAlpha:Boolean = true;
    public var culling:String = "none";
    public var depthTestMask:Boolean = true;
    public var depthTestPassCompareMode:String = "less";
    public var program:ProgramResource = null;
    public var renderTarget:TextureResource = null;
    public var renderTargetEnableDepthAndStencil:Boolean = false;
    public var renderTargetAntiAlias:int = 0;
    public var renderTargetSurfaceSelector:int = 0;
    public var scissor:Boolean = false;
    public var scissorRectangle:Rectangle = new Rectangle();
    public var stencilActionTriangleFace:String = "frontAndBack";
    public var stencilActionCompareMode:String = "always";
    public var stencilActionOnBothPass:String = "keep";
    public var stencilActionOnDepthFail:String = "keep";
    public var stencilActionOnDepthPassStencilFail:String = "keep";
    public var stencilReferenceValue:uint = 0;
    public var stencilReadMask:uint = 255;
    public var stencilWriteMask:uint = 255;
    public var textures:Vector.<TextureResource> = new Vector.<TextureResource>(8,true);
    public var vertexBuffers:Vector.<VertexBufferResource> = new Vector.<VertexBufferResource>(8,true);
    public var vertexBuffersOffsets:Vector.<int> = new Vector.<int>(8,true);
    public var vertexBuffersFormats:Vector.<String> = new Vector.<String>(8,true);
    public var vertexConstants:Vector.<Number> = new Vector.<Number>(128 * 4,true);
    public var fragmentConstants:Vector.<Number> = new Vector.<Number>(28 * 4,true);

    public function RenderState() {
      super();
    }
  }
}
