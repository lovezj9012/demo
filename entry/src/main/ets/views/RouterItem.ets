
import router from '@ohos.router'
import RouterInfo from '../viewmodel/RouterInfo'
@Component
export default struct RouterItem{

  rout:RouterInfo
  index:number

  build(){
    Row(){
      Text(this.index+".")
        .fontSize(20)
        .fontColor(Color.White)
      Blank()
      Text(this.rout.title)
        .fontSize(20)
        .fontColor(Color.White)
    }
    .width('90%')
    .padding(12)
    .backgroundColor('#38f')
    .borderRadius(20)
    .shadow({radius:6,color:'#4F000000',offsetX:2,offsetY:4})
    .onClick(()=>{
      router.pushUrl({
        url:this.rout.url,
        params:{id:this.index}
      },router.RouterMode.Single,err=>{
        if(err){
          console.log(`路由失败。errorCode:${err.code},errorMessage:${err.message}`)
        }
      })
    })
  }
}