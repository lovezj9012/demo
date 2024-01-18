import { Header } from '../components/Header'
import ShopInfo from '../viewmodel/ShopInfo'
import ShopItem from '../views/ShopItem'
import ShopModel from '../model/ShopModel'
@Entry
@Component
struct ShopPage {
  @State shops: ShopInfo[] = []
  isLoading:boolean=false
  isMore:boolean=true

  aboutToAppear() {
    //加载商品数据
    this.loadShopInfo()
  }

  build() {
    Column({space:10}) {

      Header({title:'商品列表'})

      List({space:10}){
        ForEach(this.shops,shopInfo=>{
          ListItem(){
            ShopItem({shop:shopInfo})
          }
        })
      }
      .width('100%')
      .layoutWeight(1)
      .onReachEnd(()=>{
        if(!this.isLoading&&this.isMore){
          this.isLoading=true
          //翻页
          ShopModel.pageNo++
          this.loadShopInfo()
        }
      })

    }
    .width('100%')
    .height('100%')
    .padding(10)
    .backgroundColor('#e1e2e3')

  }

  loadShopInfo(){
    //TODO 加载数据
    //ShopModel.getShops()
    ShopModel.getShopByAxios()
      .then(shops=>{
        shops.forEach(s=>{
          s.images.forEach((src,i)=>{
            s.images[i]='http://localhost:3000'+src
          })
        })
        if(!shops||shops.length===0){
          this.isMore=false
        }
        this.shops=this.shops.concat(shops)
        this.isLoading=false
      })

  }

}