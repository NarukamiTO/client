package projects.tanks.client.battlefield.models.battle.battlefield {
  import alternativa.osgi.OSGi;
  import alternativa.protocol.ICodec;
  import alternativa.protocol.IProtocol;
  import alternativa.protocol.OptionalMap;
  import alternativa.protocol.ProtocolBuffer;
  import alternativa.protocol.info.CollectionCodecInfo;
  import alternativa.protocol.info.EnumCodecInfo;
  import alternativa.protocol.info.TypeCodecInfo;
  import alternativa.types.Float;
  import alternativa.types.Long;
  import flash.utils.ByteArray;
  import platform.client.fp10.core.model.IModel;
  import platform.client.fp10.core.model.impl.Model;
  import platform.client.fp10.core.network.command.SpaceCommand;
  import platform.client.fp10.core.type.IGameObject;
  import platform.client.fp10.core.type.ISpace;
  import projects.tanks.client.battlefield.models.battle.battlefield.fps.FpsStatisticType;

  public class BattlefieldModelServer {
    private var protocol:IProtocol;
    private var protocolBuffer:ProtocolBuffer;
    private var _dgId:Long = Long.getLong(312624829,1518890877);
    private var _dg_deltasCodec:ICodec;
    private var _kdId:Long = Long.getLong(312624829,1518890663);
    private var _kd_typeCodec:ICodec;
    private var _sendTimeStatisticsCommandId:Long = Long.getLong(1789749753,1049490765);
    private var _sendTimeStatisticsCommand_statisticTypeCodec:ICodec;
    private var _sendTimeStatisticsCommand_averageFPSCodec:ICodec;
    private var _xcId:Long = Long.getLong(312624829,1518890261);
    private var model:IModel;

    public function BattlefieldModelServer(param1:IModel) {
      super();
      this.model = param1;
      var local2:ByteArray = new ByteArray();
      this.protocol = IProtocol(OSGi.getInstance().getService(IProtocol));
      this.protocolBuffer = new ProtocolBuffer(local2,local2,new OptionalMap());
      this._dg_deltasCodec = this.protocol.getCodec(new CollectionCodecInfo(new TypeCodecInfo(int,false),false,1));
      this._kd_typeCodec = this.protocol.getCodec(new TypeCodecInfo(int,false));
      this._sendTimeStatisticsCommand_statisticTypeCodec = this.protocol.getCodec(new EnumCodecInfo(FpsStatisticType,false));
      this._sendTimeStatisticsCommand_averageFPSCodec = this.protocol.getCodec(new TypeCodecInfo(Float,false));
    }

    public function dg(param1:Vector.<int>) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._dg_deltasCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._dgId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function kd(param1:int) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._kd_typeCodec.encode(this.protocolBuffer,param1);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local2:SpaceCommand = new SpaceCommand(Model.object.id,this._kdId,this.protocolBuffer);
      var local3:IGameObject = Model.object;
      var local4:ISpace = local3.space;
      local4.commandSender.sendCommand(local2);
      this.protocolBuffer.optionalMap.clear();
    }

    public function sendTimeStatisticsCommand(param1:FpsStatisticType, param2:Number) : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      this._sendTimeStatisticsCommand_statisticTypeCodec.encode(this.protocolBuffer,param1);
      this._sendTimeStatisticsCommand_averageFPSCodec.encode(this.protocolBuffer,param2);
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local3:SpaceCommand = new SpaceCommand(Model.object.id,this._sendTimeStatisticsCommandId,this.protocolBuffer);
      var local4:IGameObject = Model.object;
      var local5:ISpace = local4.space;
      local5.commandSender.sendCommand(local3);
      this.protocolBuffer.optionalMap.clear();
    }

    public function xc() : void {
      ByteArray(this.protocolBuffer.writer).position = 0;
      ByteArray(this.protocolBuffer.writer).length = 0;
      ByteArray(this.protocolBuffer.writer).position = 0;
      if(Model.object == null) {
        throw new Error("Execute method without model context.");
      }
      var local1:SpaceCommand = new SpaceCommand(Model.object.id,this._xcId,this.protocolBuffer);
      var local2:IGameObject = Model.object;
      var local3:ISpace = local2.space;
      local3.commandSender.sendCommand(local1);
      this.protocolBuffer.optionalMap.clear();
    }
  }
}
