package alternativa.tanks.models.sfx.colortransform {
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.type.IGameObject;

  public class ColorTransformConsumerEvents implements ColorTransformConsumer {
    private var object:IGameObject;
    private var impl:Vector.<Object>;

    public function ColorTransformConsumerEvents(param1:IGameObject, param2:Vector.<Object>) {
      super();
      this.object = param1;
      this.impl = param2;
    }

    public function initColorTransform(param1:Vector.<ColorTransformEntry>) : void {
      var i:int = 0;
      var m:ColorTransformConsumer = null;
      var entries:Vector.<ColorTransformEntry> = param1;
      try {
        Model.object = this.object;
        i = 0;
        while(i < this.impl.length) {
          m = ColorTransformConsumer(this.impl[i]);
          m.initColorTransform(entries);
          i++;
        }
      }
      finally {
        Model.popObject();
      }
    }
  }
}
