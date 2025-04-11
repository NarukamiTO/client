package alternativa.physics.collision {
  import alternativa.physics.collision.types.AABB;

  public class CollisionKdNode {
    public var indices:Vector.<int>;
    public var splitIndices:Vector.<int>;
    public var boundBox:AABB;
    public var parent:CollisionKdNode;
    public var splitTree:CollisionKdTree2D;
    public var axis:int = -1;
    public var coord:Number;
    public var positiveNode:CollisionKdNode;
    public var negativeNode:CollisionKdNode;

    public function CollisionKdNode() {
      super();
    }

    public function destroy() : void {
      if(Boolean(this.positiveNode)) {
        this.positiveNode.destroy();
        this.positiveNode = null;
      }
      if(Boolean(this.negativeNode)) {
        this.negativeNode.destroy();
        this.negativeNode = null;
      }
      if(Boolean(this.splitTree)) {
        this.splitTree.destroyTree();
        this.splitTree = null;
      }
      this.parent = null;
      this.boundBox = null;
      this.indices = null;
      this.splitIndices = null;
    }
  }
}
