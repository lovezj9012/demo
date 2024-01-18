
import router from '@ohos.router'
import RouterInfo from '../viewmodel/RouterInfo'
import IndexFontSizePanel from '../views/IndexFontSizePanel';
import RouterItem from '../views/RouterItem'
import PreferenceUtil from '../common/utils/PreferencesUtil'

const routers:RouterInfo []=[
  new RouterInfo('pages/ImagePage', '图片展示'),
  new RouterInfo('pages/TaskPage', '任务列表'),
  new RouterInfo('pages/ItemPage', '商品列表'),
  new RouterInfo('pages/AnimationPage','小鱼动画'),
  new RouterInfo('pages/AnimationPage2','摇杆小鱼动画'),
  new RouterInfo('pages/LifeCirclePage','UIAbility生命周期'),
  new RouterInfo('pages/PageLifePage','页面生命周期'),
  new RouterInfo('pages/DocumentListPage','UIAbility启动模式'),
  new RouterInfo('pages/ShopPage','商品查询'),
  new RouterInfo('pages/PropPage','数据持久化')

];

@Entry
@Component
struct Index {
  @State message: string = '页面列表'
  @State showPanel:boolean=false
  @Provide fontSize:number =16



  tag: string = 'Index Page'

  async aboutToAppear(){
    this.fontSize = await PreferenceUtil.getPreferenceValue('MyPreference','IndexFontSize',16) as number
    console.log(this.tag, 'about to appear')
  }

  onPageShow(){
    console.log(this.tag, 'on page show')
  }

  onBackPress(){
    console.log(this.tag, 'on back press')
  }

  onPageHide(){
    console.log(this.tag, 'on page hide')
  }

  aboutToDisappear(){
    console.log(this.tag, 'about to disappear')
  }

  build() {
    Row() {
      Column() {
        //标题
        Row() {
          Text(this.message)
            .fontSize(50)
            .fontWeight(FontWeight.Bold)
            .fontColor('#36B')
            .height(80)
            .onClick(() => {
              this.message = "Hello ArkTS!";
            })
          Image($r('app.media.ic_public_settings'))
            .width(30)
            .onClick(() => {
              animateTo({
                duration: 500,
                curve: Curve.EaseOut
              }, () => this.showPanel = !this.showPanel)
            })
        }

        //导航列表
        List({space:15}){
          ForEach(routers,(item:RouterInfo,index)=>{
            ListItem(){
              RouterItem({rout:item,index:index+1})
            }
          })
        }
        .layoutWeight(1)
        .alignListItem(ListItemAlign.Center)
        .width('100%')

        //字体修改面板
        if(this.showPanel){
          IndexFontSizePanel()
            .transition({
              translate:{y:115}
            })
        }

        /*//Image('https://lmg.jj20.com/up/allimg/tp10/22022312542M617-0-lp.jpg')
          //Image($r('app.media.icon'))
          Image($rawfile('iconraw.png'))
          .width(300)
            .interpolation(ImageInterpolation.High)



        Text("用户名")
          .lineHeight(20)
          .fontSize(20)
          */


      }
      .width('100%')
    }
    .height('100%')
  }
}