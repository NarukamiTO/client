package alternativa.tanks.models.sfx.colortransform {
  import platform.client.fp10.core.model.ObjectLoadPostListener;
  import projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.ColorTransformModelBase;
  import projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.IColorTransformModelBase;
  import projects.tanks.client.battlefield.models.tankparts.sfx.colortransform.struct.ColorTransformStruct;

  [ModelInfo]
  public class ColorTransformModel extends ColorTransformModelBase implements IColorTransformModelBase, ObjectLoadPostListener {
    public function ColorTransformModel() {
      super();
    }

    [Obfuscation(rename="false")]
    public function objectLoadedPost() : void {
      var local1:Vector.<ColorTransformStruct> = getInitParam().colorTransforms;
      var local2:uint = local1.length;
      var local3:Vector.<ColorTransformEntry> = new Vector.<ColorTransformEntry>(local2);
      var local4:int = 0;
      while(local4 < local2) {
        local3[local4] = new ColorTransformEntry(local1[local4]);
        local4++;
      }
      if(local3.length != 0) {
        ColorTransformConsumer(object.event(ColorTransformConsumer)).initColorTransform(local3);
      }
    }
  }
}
