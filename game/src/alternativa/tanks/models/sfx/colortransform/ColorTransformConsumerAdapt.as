package alternativa.tanks.models.sfx.colortransform {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ColorTransformConsumerAdapt implements ColorTransformConsumer {
    private var object:IGameObject;
    private var impl:ColorTransformConsumer;

    public function ColorTransformConsumerAdapt(param1:IGameObject, param2:ColorTransformConsumer) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function initColorTransform(param1:Vector.<ColorTransformEntry>) : void {
      var entries:Vector.<ColorTransformEntry> = param1;
      try {
        Model.object = this.object;
        this.impl.initColorTransform(entries);
      }
      finally {
        Model.popObject();
      }
    }
  }
}
