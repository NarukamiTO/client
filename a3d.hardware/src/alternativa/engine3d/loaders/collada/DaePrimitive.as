package alternativa.engine3d.loaders.collada {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;

  use namespace alternativa3d;
  use namespace collada;

  public class DaePrimitive extends DaeElement {
    private var verticesInput:DaeInput;
    private var texCoordsInputs:Vector.<DaeInput>;
    private var inputsStride:int;

    public function DaePrimitive(param1:XML, param2:DaeDocument) {
      super(param1,param2);
    }

    override protected function parseImplementation() : Boolean {
      this.parseInputs();
      return true;
    }

    private function parseInputs() : void {
      var local5:DaeInput = null;
      var local6:String = null;
      var local7:int = 0;
      this.texCoordsInputs = new Vector.<DaeInput>();
      var local1:XMLList = data.input;
      var local2:int = 0;
      var local3:int = 0;
      var local4:int = int(local1.length());
      for(; local3 < local4; local7 = local5.offset,local2 = local7 > local2 ? local7 : local2,local3++) {
        local5 = new DaeInput(local1[local3],document);
        local6 = local5.semantic;
        if(local6 == null) {
          continue;
        }
        switch(local6) {
          case "VERTEX":
            if(this.verticesInput == null) {
              this.verticesInput = local5;
            }
            break;
          case "TEXCOORD":
            this.texCoordsInputs.push(local5);
            break;
        }
      }
      this.inputsStride = local2 + 1;
    }

    private function findTexCoordsInput(param1:int) : DaeInput {
      var local4:DaeInput = null;
      var local2:int = 0;
      var local3:int = int(this.texCoordsInputs.length);
      while(local2 < local3) {
        local4 = this.texCoordsInputs[local2];
        if(local4.setNum == param1) {
          return local4;
        }
        local2++;
      }
      return this.texCoordsInputs.length > 0 ? this.texCoordsInputs[0] : null;
    }

    private function get type() : String {
      return data.localName() as String;
    }

    public function fillInMesh(param1:Mesh, param2:Vector.<Vertex>, param3:DaeInstanceMaterial = null) : void {
      var local6:DaeInput = null;
      var local7:Material = null;
      var local8:Vector.<Number> = null;
      var local11:XML = null;
      var local12:Array = null;
      var local13:DaeMaterial = null;
      var local14:Vertex = null;
      var local15:DaeSource = null;
      var local16:XMLList = null;
      var local17:int = 0;
      var local18:int = 0;
      var local19:XML = null;
      var local20:Array = null;
      var local4:XML = data.@count[0];
      if(local4 == null) {
        document.logger.logNotEnoughDataError(data);
        return;
      }
      var local5:int = parseInt(local4.toString(),10);
      if(param3 != null) {
        local13 = param3.material;
        local13.parse();
        if(local13.diffuseTexCoords != null) {
          local6 = this.findTexCoordsInput(param3.getBindVertexInputSetNum(local13.diffuseTexCoords));
        } else {
          local6 = this.findTexCoordsInput(-1);
        }
        local13.used = true;
        local7 = local13.material;
      } else {
        local6 = this.findTexCoordsInput(-1);
      }
      if(local6 != null) {
        for each(local14 in param2) {
          while(local14 != null && local14.alternativa3d::index != -1) {
            local14.alternativa3d::index = -2;
            local14 = local14.alternativa3d::value;
          }
        }
      }
      var local9:int = 1;
      var local10:int = 0;
      if(local6 != null) {
        local15 = local6.prepareSource(2);
        if(local15 != null) {
          local8 = local15.numbers;
          local9 = local15.stride;
          local10 = local6.offset;
        }
      }
      switch(this.type) {
        case "polygons":
          if(data.ph.length() > 0) {
          }
          local16 = data.p;
          local17 = 0;
          local18 = int(local16.length());
          while(local17 < local18) {
            local12 = parseIntsArray(local16[local17]);
            this.fillInPolygon(param1,local7,param2,this.verticesInput.offset,local12.length / this.inputsStride,local12,local8,local9,local10);
            local17++;
          }
          break;
        case "polylist":
          local11 = data.p[0];
          if(local11 == null) {
            document.logger.logNotEnoughDataError(data);
            return;
          }
          local12 = parseIntsArray(local11);
          local19 = data.vcount[0];
          if(local19 != null) {
            local20 = parseIntsArray(local19);
            if(local20.length < local5) {
              return;
            }
            this.fillInPolylist(param1,local7,param2,this.verticesInput.offset,local5,local12,local20,local8,local9,local10);
          } else {
            this.fillInPolygon(param1,local7,param2,this.verticesInput.offset,local5,local12,local8,local9,local10);
          }
          break;
        case "triangles":
          local11 = data.p[0];
          if(local11 == null) {
            document.logger.logNotEnoughDataError(data);
            return;
          }
          local12 = parseIntsArray(local11);
          this.fillInTriangles(param1,local7,param2,this.verticesInput.offset,local5,local12,local8,local9,local10);
          break;
      }
    }

    private function applyUV(param1:Mesh, param2:Vertex, param3:Vector.<Number>, param4:int) : Vertex {
      var local7:Vertex = null;
      var local5:Number = param3[param4];
      var local6:Number = 1 - param3[int(param4 + 1)];
      if(param2.alternativa3d::index == -1) {
        param2.u = local5;
        param2.v = local6;
        param2.alternativa3d::index = param4;
        return param2;
      }
      if(param2.alternativa3d::index == param4) {
        return param2;
      }
      while(param2.alternativa3d::value != null) {
        param2 = param2.alternativa3d::value;
        if(param2.alternativa3d::index == param4) {
          return param2;
        }
      }
      local7 = new Vertex();
      local7.alternativa3d::next = param1.alternativa3d::vertexList;
      param1.alternativa3d::vertexList = local7;
      local7.x = param2.x;
      local7.y = param2.y;
      local7.z = param2.z;
      local7.u = local5;
      local7.v = local6;
      param2.alternativa3d::value = local7;
      local7.alternativa3d::index = param4;
      return local7;
    }

    private function fillInPolygon(param1:Mesh, param2:Material, param3:Vector.<Vertex>, param4:int, param5:int, param6:Array, param7:Vector.<Number>, param8:int = 1, param9:int = 0) : void {
      var local11:Wrapper = null;
      var local13:Vertex = null;
      var local14:Wrapper = null;
      var local10:Face = new Face();
      local10.material = param2;
      local10.alternativa3d::next = param1.alternativa3d::faceList;
      param1.alternativa3d::faceList = local10;
      var local12:int = 0;
      while(local12 < param5) {
        local13 = param3[param6[int(this.inputsStride * local12 + param4)]];
        if(param7 != null) {
          local13 = this.applyUV(param1,local13,param7,param8 * param6[int(this.inputsStride * local12 + param9)]);
        }
        local14 = new Wrapper();
        local14.alternativa3d::vertex = local13;
        if(local11 != null) {
          local11.alternativa3d::next = local14;
        } else {
          local10.alternativa3d::wrapper = local14;
        }
        local11 = local14;
        local12++;
      }
    }

    private function fillInPolylist(param1:Mesh, param2:Material, param3:Vector.<Vertex>, param4:int, param5:int, param6:Array, param7:Array, param8:Vector.<Number> = null, param9:int = 1, param10:int = 0) : void {
      var local13:int = 0;
      var local14:Face = null;
      var local15:Wrapper = null;
      var local16:int = 0;
      var local17:int = 0;
      var local18:Vertex = null;
      var local19:Wrapper = null;
      var local11:int = 0;
      var local12:int = 0;
      while(local12 < param5) {
        local13 = int(param7[local12]);
        if(local13 >= 3) {
          local14 = new Face();
          local14.material = param2;
          local14.alternativa3d::next = param1.alternativa3d::faceList;
          param1.alternativa3d::faceList = local14;
          local15 = null;
          local16 = 0;
          while(local16 < local13) {
            local17 = this.inputsStride * (local11 + local16);
            local18 = param3[param6[int(local17 + param4)]];
            if(param8 != null) {
              local18 = this.applyUV(param1,local18,param8,param9 * param6[int(local17 + param10)]);
            }
            local19 = new Wrapper();
            local19.alternativa3d::vertex = local18;
            if(local15 != null) {
              local15.alternativa3d::next = local19;
            } else {
              local14.alternativa3d::wrapper = local19;
            }
            local15 = local19;
            local16++;
          }
          local11 += local13;
        }
        local12++;
      }
    }

    private function fillInTriangles(param1:Mesh, param2:Material, param3:Vector.<Vertex>, param4:int, param5:int, param6:Array, param7:Vector.<Number> = null, param8:int = 1, param9:int = 0) : void {
      var local11:int = 0;
      var local12:int = 0;
      var local13:Vertex = null;
      var local14:Vertex = null;
      var local15:Vertex = null;
      var local16:Face = null;
      var local17:int = 0;
      var local10:int = 0;
      while(local10 < param5) {
        local11 = 3 * this.inputsStride * local10;
        local12 = local11 + param4;
        local13 = param3[param6[int(local12)]];
        local14 = param3[param6[int(local12 + this.inputsStride)]];
        local15 = param3[param6[int(local12 + 2 * this.inputsStride)]];
        if(param7 != null) {
          local17 = local11 + param9;
          local13 = this.applyUV(param1,local13,param7,param8 * param6[int(local17)]);
          local14 = this.applyUV(param1,local14,param7,param8 * param6[int(local17 + this.inputsStride)]);
          local15 = this.applyUV(param1,local15,param7,param8 * param6[int(local17 + 2 * this.inputsStride)]);
        }
        local16 = new Face();
        local16.material = param2;
        local16.alternativa3d::next = param1.alternativa3d::faceList;
        param1.alternativa3d::faceList = local16;
        local16.alternativa3d::wrapper = new Wrapper();
        local16.alternativa3d::wrapper.alternativa3d::vertex = local13;
        local16.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
        local16.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = local14;
        local16.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
        local16.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = local15;
        local10++;
      }
    }

    public function verticesEquals(param1:DaeVertices) : Boolean {
      var local2:DaeVertices = document.findVertices(this.verticesInput.source);
      if(local2 == null) {
        document.logger.logNotFoundError(this.verticesInput.source);
      }
      return local2 == param1;
    }

    public function get materialSymbol() : String {
      var local1:XML = data.@material[0];
      return local1 == null ? null : local1.toString();
    }
  }
}
