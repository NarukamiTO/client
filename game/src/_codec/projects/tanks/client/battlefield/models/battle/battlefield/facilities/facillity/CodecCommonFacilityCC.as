package _codec.projects.tanks.client.battlefield.models.battle.battlefield.facilities.facillity {
  import alternativa.osgi.OSGi;
  import alternativa.osgi.service.clientlog.IClientLog;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Long;
  import platform.client.fp10.core.resource.types.TextureResource;
  import projects.tanks.client.battlefield.models.battle.battlefield.facilities.facillity.CommonFacilityCC;
  import projects.tanks.client.battlefield.types.Vector3d;
  import projects.tanks.client.battleservice.model.battle.team.BattleTeam;
  import projects.tanks.clients.flash.resources.resource.Tanks3DSResource;

  public class CodecCommonFacilityCC implements ICodec {
    public static var log:IClientLog = IClientLog(OSGi.getInstance().getService(IClientLog));

    private var codec_facilityObject:ICodec;
    private var codec_facilityTeam:ICodec;
    private var codec_facilityTexture:ICodec;
    private var codec_localCenter:ICodec;
    private var codec_ownerId:ICodec;
    private var codec_position:ICodec;
    private var codec_rotation:ICodec;
    private var codec_useLight:ICodec;
    private var codec_useShadows:ICodec;

    public function CodecCommonFacilityCC() {
      super();
    }

    public function init(param1:IProtocol) : void {
      this.codec_facilityObject = param1.getCodec(new TypeCodecInfo(Tanks3DSResource,false));
      this.codec_facilityTeam = param1.getCodec(new EnumCodecInfo(BattleTeam,false));
      this.codec_facilityTexture = param1.getCodec(new TypeCodecInfo(TextureResource,false));
      this.codec_localCenter = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_ownerId = param1.getCodec(new TypeCodecInfo(Long,false));
      this.codec_position = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_rotation = param1.getCodec(new TypeCodecInfo(Vector3d,false));
      this.codec_useLight = param1.getCodec(new TypeCodecInfo(Boolean,false));
      this.codec_useShadows = param1.getCodec(new TypeCodecInfo(Boolean,false));
    }

    public function decode(param1:ProtocolBuffer) : Object {
      var local2:CommonFacilityCC = new CommonFacilityCC();
      local2.facilityObject = this.codec_facilityObject.decode(param1) as Tanks3DSResource;
      local2.facilityTeam = this.codec_facilityTeam.decode(param1) as BattleTeam;
      local2.facilityTexture = this.codec_facilityTexture.decode(param1) as TextureResource;
      local2.localCenter = this.codec_localCenter.decode(param1) as Vector3d;
      local2.ownerId = this.codec_ownerId.decode(param1) as Long;
      local2.position = this.codec_position.decode(param1) as Vector3d;
      local2.rotation = this.codec_rotation.decode(param1) as Vector3d;
      local2.useLight = this.codec_useLight.decode(param1) as Boolean;
      local2.useShadows = this.codec_useShadows.decode(param1) as Boolean;
      return local2;
    }

    public function encode(param1:ProtocolBuffer, param2:Object) : void {
      if(param2 == null) {
        throw new Error("Object is null. Use @ProtocolOptional annotation.");
      }
      var local3:CommonFacilityCC = CommonFacilityCC(param2);
      this.codec_facilityObject.encode(param1,local3.facilityObject);
      this.codec_facilityTeam.encode(param1,local3.facilityTeam);
      this.codec_facilityTexture.encode(param1,local3.facilityTexture);
      this.codec_localCenter.encode(param1,local3.localCenter);
      this.codec_ownerId.encode(param1,local3.ownerId);
      this.codec_position.encode(param1,local3.position);
      this.codec_rotation.encode(param1,local3.rotation);
      this.codec_useLight.encode(param1,local3.useLight);
      this.codec_useShadows.encode(param1,local3.useShadows);
    }
  }
}
