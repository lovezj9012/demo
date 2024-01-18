
import http from '@ohos.net.http';
import ShopInfo from '../viewmodel/ShopInfo';
import axios from '@ohos/axios'

class ShopModel{
  baseUrl:string='http://localhost:3000'
  pageNo:number=1

  getShops():Promise< ShopInfo[]>{
    return new Promise((resolve,reject)=>{
      //1.创建http请求对象
      let httpRequest = http.createHttp();
      //2.发送请求
      httpRequest.request(`${this.baseUrl}/shops?pageNo=${this.pageNo}&pageSize=3`,
        {
          method:http.RequestMethod.GET
        }
      )
        .then(res=>{
          if(res.responseCode===200){
            //查询成功
            console.log('查询商铺成功！',res.result)
            resolve(JSON.parse(res.result.toString()))
          }else{
            console.log(`查询商铺信息失败！error:${JSON.stringify(res)}`)
            reject('查询商铺失败！')
          }
        })
        .catch(error=>{
          console.log(`查询商铺信息失败！error:${JSON.stringify(error)}`)
          reject('查询商铺失败！')
        })
    })


  }

  getShopByAxios():Promise<ShopInfo[]>{
    return new Promise((resolve,reject)=>{
      axios.get(`${this.baseUrl}/shops`,{
        params:{pageNo:this.pageNo,pageSize:3}
      })
        .then(res=>{
          if(res.status===200){
            //查询成功
            console.log(`查询商铺成功！${JSON.stringify(res.data)}`)
            resolve(res.data)
          }else{
            console.log(`查询商铺失败！error:${JSON.stringify(res)}`)
            reject('查询商铺失败！')
          }
        })
        .catch(err=>{
          console.log(`查询商铺失败！error:${JSON.stringify(err)}`)
          reject('查询商铺失败！')
        })

    })
  }



}

const shopModel=new ShopModel();

export default shopModel as ShopModel;
