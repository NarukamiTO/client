package alternativa.engine3d.primitives {
  import alternativa.engine3d.alternativa3d;
  import alternativa.engine3d.core.Face;
  import alternativa.engine3d.core.Object3D;
  import alternativa.engine3d.core.Vertex;
  import alternativa.engine3d.core.Wrapper;
  import alternativa.engine3d.materials.Material;
  import alternativa.engine3d.objects.Mesh;

  use namespace alternativa3d;

  public class GeoSphere extends Mesh {
    public function GeoSphere(param1:Number = 100, param2:uint = 2, param3:Boolean = false, param4:Material = null) {
      var local9:uint = 0;
      var local10:uint = 0;
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local16:uint = 0;
      var local17:uint = 0;
      var local18:uint = 0;
      var local19:uint = 0;
      var local20:uint = 0;
      var local21:Vertex = null;
      var local22:Vertex = null;
      var local23:Vertex = null;
      var local24:Number = NaN;
      var local25:Number = NaN;
      var local26:Number = NaN;
      var local27:Number = NaN;
      var local28:Number = NaN;
      var local29:Number = NaN;
      super();
      if(param2 < 1) {
        throw new ArgumentError(param2 + " segments not enough.");
      }
      param1 = param1 < 0 ? 0 : param1;
      var local5:uint = 20;
      var local6:Number = Math.PI;
      var local7:Number = Math.PI * 2;
      var local8:Vector.<Vertex> = new Vector.<Vertex>();
      var local14:Number = 0.4472136 * param1;
      var local15:Number = 2 * local14;
      local8.push(this.createVertex(0,0,param1));
      local9 = 0;
      while(local9 < 5) {
        local11 = local7 * local9 / 5;
        local12 = Math.sin(local11);
        local13 = Math.cos(local11);
        local8.push(this.createVertex(local15 * local13,local15 * local12,local14));
        local9++;
      }
      local9 = 0;
      while(local9 < 5) {
        local11 = local6 * ((local9 << 1) + 1) / 5;
        local12 = Math.sin(local11);
        local13 = Math.cos(local11);
        local8.push(this.createVertex(local15 * local13,local15 * local12,-local14));
        local9++;
      }
      local8.push(this.createVertex(0,0,-param1));
      local9 = 1;
      while(local9 < 6) {
        this.interpolate(0,local9,param2,local8);
        local9++;
      }
      local9 = 1;
      while(local9 < 6) {
        this.interpolate(local9,local9 % 5 + 1,param2,local8);
        local9++;
      }
      local9 = 1;
      while(local9 < 6) {
        this.interpolate(local9,local9 + 5,param2,local8);
        local9++;
      }
      local9 = 1;
      while(local9 < 6) {
        this.interpolate(local9,(local9 + 3) % 5 + 6,param2,local8);
        local9++;
      }
      local9 = 1;
      while(local9 < 6) {
        this.interpolate(local9 + 5,local9 % 5 + 6,param2,local8);
        local9++;
      }
      local9 = 6;
      while(local9 < 11) {
        this.interpolate(11,local9,param2,local8);
        local9++;
      }
      local10 = 0;
      while(local10 < 5) {
        local9 = 1;
        while(local9 <= param2 - 2) {
          this.interpolate(12 + local10 * (param2 - 1) + local9,12 + (local10 + 1) % 5 * (param2 - 1) + local9,local9 + 1,local8);
          local9++;
        }
        local10++;
      }
      local10 = 0;
      while(local10 < 5) {
        local9 = 1;
        while(local9 <= param2 - 2) {
          this.interpolate(12 + (local10 + 15) * (param2 - 1) + local9,12 + (local10 + 10) * (param2 - 1) + local9,local9 + 1,local8);
          local9++;
        }
        local10++;
      }
      local10 = 0;
      while(local10 < 5) {
        local9 = 1;
        while(local9 <= param2 - 2) {
          this.interpolate(12 + ((local10 + 1) % 5 + 15) * (param2 - 1) + param2 - 2 - local9,12 + (local10 + 10) * (param2 - 1) + param2 - 2 - local9,local9 + 1,local8);
          local9++;
        }
        local10++;
      }
      local10 = 0;
      while(local10 < 5) {
        local9 = 1;
        while(local9 <= param2 - 2) {
          this.interpolate(12 + ((local10 + 1) % 5 + 25) * (param2 - 1) + local9,12 + (local10 + 25) * (param2 - 1) + local9,local9 + 1,local8);
          local9++;
        }
        local10++;
      }
      local10 = 0;
      while(local10 < local5) {
        local16 = 0;
        while(local16 < param2) {
          local17 = 0;
          while(local17 <= local16) {
            local18 = this.findVertices(param2,local10,local16,local17);
            local19 = this.findVertices(param2,local10,local16 + 1,local17);
            local20 = this.findVertices(param2,local10,local16 + 1,local17 + 1);
            local21 = local8[local18];
            local22 = local8[local19];
            local23 = local8[local20];
            if(local21.y >= 0 && local21.x < 0 && (local22.y < 0 || local23.y < 0)) {
              local24 = Math.atan2(local21.y,local21.x) / local7 - 0.5;
            } else {
              local24 = Math.atan2(local21.y,local21.x) / local7 + 0.5;
            }
            local25 = -Math.asin(local21.z / param1) / local6 + 0.5;
            if(local22.y >= 0 && local22.x < 0 && (local21.y < 0 || local23.y < 0)) {
              local26 = Math.atan2(local22.y,local22.x) / local7 - 0.5;
            } else {
              local26 = Math.atan2(local22.y,local22.x) / local7 + 0.5;
            }
            local27 = -Math.asin(local22.z / param1) / local6 + 0.5;
            if(local23.y >= 0 && local23.x < 0 && (local21.y < 0 || local22.y < 0)) {
              local28 = Math.atan2(local23.y,local23.x) / local7 - 0.5;
            } else {
              local28 = Math.atan2(local23.y,local23.x) / local7 + 0.5;
            }
            local29 = -Math.asin(local23.z / param1) / local6 + 0.5;
            if(local18 == 0 || local18 == 11) {
              local24 = local26 + (local28 - local26) * 0.5;
            }
            if(local19 == 0 || local19 == 11) {
              local26 = local24 + (local28 - local24) * 0.5;
            }
            if(local20 == 0 || local20 == 11) {
              local28 = local24 + (local26 - local24) * 0.5;
            }
            if(local21.alternativa3d::offset > 0 && local21.u != local24) {
              local21 = this.createVertex(local21.x,local21.y,local21.z);
            }
            local21.u = local24;
            local21.v = local25;
            local21.alternativa3d::offset = 1;
            if(local22.alternativa3d::offset > 0 && local22.u != local26) {
              local22 = this.createVertex(local22.x,local22.y,local22.z);
            }
            local22.u = local26;
            local22.v = local27;
            local22.alternativa3d::offset = 1;
            if(local23.alternativa3d::offset > 0 && local23.u != local28) {
              local23 = this.createVertex(local23.x,local23.y,local23.z);
            }
            local23.u = local28;
            local23.v = local29;
            local23.alternativa3d::offset = 1;
            if(param3) {
              this.createFace(local21,local23,local22,param4);
            } else {
              this.createFace(local21,local22,local23,param4);
            }
            if(local17 < local16) {
              local19 = this.findVertices(param2,local10,local16,local17 + 1);
              local22 = local8[local19];
              if(local21.y >= 0 && local21.x < 0 && (local22.y < 0 || local23.y < 0)) {
                local24 = Math.atan2(local21.y,local21.x) / local7 - 0.5;
              } else {
                local24 = Math.atan2(local21.y,local21.x) / local7 + 0.5;
              }
              local25 = -Math.asin(local21.z / param1) / local6 + 0.5;
              if(local22.y >= 0 && local22.x < 0 && (local21.y < 0 || local23.y < 0)) {
                local26 = Math.atan2(local22.y,local22.x) / local7 - 0.5;
              } else {
                local26 = Math.atan2(local22.y,local22.x) / local7 + 0.5;
              }
              local27 = -Math.asin(local22.z / param1) / local6 + 0.5;
              if(local23.y >= 0 && local23.x < 0 && (local21.y < 0 || local22.y < 0)) {
                local28 = Math.atan2(local23.y,local23.x) / local7 - 0.5;
              } else {
                local28 = Math.atan2(local23.y,local23.x) / local7 + 0.5;
              }
              local29 = -Math.asin(local23.z / param1) / local6 + 0.5;
              if(local18 == 0 || local18 == 11) {
                local24 = local26 + (local28 - local26) * 0.5;
              }
              if(local19 == 0 || local19 == 11) {
                local26 = local24 + (local28 - local24) * 0.5;
              }
              if(local20 == 0 || local20 == 11) {
                local28 = local24 + (local26 - local24) * 0.5;
              }
              if(local21.alternativa3d::offset > 0 && local21.u != local24) {
                local21 = this.createVertex(local21.x,local21.y,local21.z);
              }
              local21.u = local24;
              local21.v = local25;
              local21.alternativa3d::offset = 1;
              if(local22.alternativa3d::offset > 0 && local22.u != local26) {
                local22 = this.createVertex(local22.x,local22.y,local22.z);
              }
              local22.u = local26;
              local22.v = local27;
              local22.alternativa3d::offset = 1;
              if(local23.alternativa3d::offset > 0 && local23.u != local28) {
                local23 = this.createVertex(local23.x,local23.y,local23.z);
              }
              local23.u = local28;
              local23.v = local29;
              local23.alternativa3d::offset = 1;
              if(param3) {
                this.createFace(local21,local22,local23,param4);
              } else {
                this.createFace(local21,local23,local22,param4);
              }
            }
            local17++;
          }
          local16++;
        }
        local10++;
      }
      calculateFacesNormals(true);
      boundMinX = -param1;
      boundMinY = -param1;
      boundMinZ = -param1;
      boundMaxX = param1;
      boundMaxY = param1;
      boundMaxZ = param1;
    }

    private function createVertex(param1:Number, param2:Number, param3:Number) : Vertex {
      var local4:Vertex = new Vertex();
      local4.x = param1;
      local4.y = param2;
      local4.z = param3;
      local4.alternativa3d::offset = -1;
      local4.alternativa3d::next = alternativa3d::vertexList;
      alternativa3d::vertexList = local4;
      return local4;
    }

    private function createFace(param1:Vertex, param2:Vertex, param3:Vertex, param4:Material) : void {
      var local5:Face = new Face();
      local5.material = param4;
      local5.alternativa3d::wrapper = new Wrapper();
      local5.alternativa3d::wrapper.alternativa3d::vertex = param1;
      local5.alternativa3d::wrapper.alternativa3d::next = new Wrapper();
      local5.alternativa3d::wrapper.alternativa3d::next.alternativa3d::vertex = param2;
      local5.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next = new Wrapper();
      local5.alternativa3d::wrapper.alternativa3d::next.alternativa3d::next.alternativa3d::vertex = param3;
      local5.alternativa3d::next = alternativa3d::faceList;
      alternativa3d::faceList = local5;
    }

    private function interpolate(param1:uint, param2:uint, param3:uint, param4:Vector.<Vertex>) : void {
      var local11:Number = NaN;
      var local12:Number = NaN;
      var local13:Number = NaN;
      var local14:Number = NaN;
      if(param3 < 2) {
        return;
      }
      var local5:Vertex = Vertex(param4[param1]);
      var local6:Vertex = Vertex(param4[param2]);
      var local7:Number = (local5.x * local6.x + local5.y * local6.y + local5.z * local6.z) / (local5.x * local5.x + local5.y * local5.y + local5.z * local5.z);
      local7 = local7 < -1 ? -1 : (local7 > 1 ? 1 : local7);
      var local8:Number = Math.acos(local7);
      var local9:Number = Math.sin(local8);
      var local10:uint = 1;
      while(local10 < param3) {
        local11 = local8 * local10 / param3;
        local12 = local8 * (param3 - local10) / param3;
        local13 = Math.sin(local11);
        local14 = Math.sin(local12);
        param4.push(this.createVertex((local5.x * local14 + local6.x * local13) / local9,(local5.y * local14 + local6.y * local13) / local9,(local5.z * local14 + local6.z * local13) / local9));
        local10++;
      }
    }

    private function findVertices(param1:uint, param2:uint, param3:uint, param4:uint) : uint {
      if(param3 == 0) {
        if(param2 < 5) {
          return 0;
        }
        if(param2 > 14) {
          return 11;
        }
        return param2 - 4;
      }
      if(param3 == param1 && param4 == 0) {
        if(param2 < 5) {
          return param2 + 1;
        }
        if(param2 < 10) {
          return (param2 + 4) % 5 + 6;
        }
        if(param2 < 15) {
          return (param2 + 1) % 5 + 1;
        }
        return (param2 + 1) % 5 + 6;
      }
      if(param3 == param1 && param4 == param1) {
        if(param2 < 5) {
          return (param2 + 1) % 5 + 1;
        }
        if(param2 < 10) {
          return param2 + 1;
        }
        if(param2 < 15) {
          return param2 - 9;
        }
        return param2 - 9;
      }
      if(param3 == param1) {
        if(param2 < 5) {
          return 12 + (5 + param2) * (param1 - 1) + param4 - 1;
        }
        if(param2 < 10) {
          return 12 + (20 + (param2 + 4) % 5) * (param1 - 1) + param4 - 1;
        }
        if(param2 < 15) {
          return 12 + (param2 - 5) * (param1 - 1) + param1 - 1 - param4;
        }
        return 12 + (5 + param2) * (param1 - 1) + param1 - 1 - param4;
      }
      if(param4 == 0) {
        if(param2 < 5) {
          return 12 + param2 * (param1 - 1) + param3 - 1;
        }
        if(param2 < 10) {
          return 12 + (param2 % 5 + 15) * (param1 - 1) + param3 - 1;
        }
        if(param2 < 15) {
          return 12 + ((param2 + 1) % 5 + 15) * (param1 - 1) + param1 - 1 - param3;
        }
        return 12 + ((param2 + 1) % 5 + 25) * (param1 - 1) + param3 - 1;
      }
      if(param4 == param3) {
        if(param2 < 5) {
          return 12 + (param2 + 1) % 5 * (param1 - 1) + param3 - 1;
        }
        if(param2 < 10) {
          return 12 + (param2 % 5 + 10) * (param1 - 1) + param3 - 1;
        }
        if(param2 < 15) {
          return 12 + (param2 % 5 + 10) * (param1 - 1) + param1 - param3 - 1;
        }
        return 12 + (param2 % 5 + 25) * (param1 - 1) + param3 - 1;
      }
      return 12 + 30 * (param1 - 1) + param2 * (param1 - 1) * (param1 - 2) / 2 + (param3 - 1) * (param3 - 2) / 2 + param4 - 1;
    }

    override public function clone() : Object3D {
      var local1:GeoSphere = new GeoSphere();
      local1.clonePropertiesFrom(this);
      return local1;
    }
  }
}
