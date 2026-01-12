#import <substrate.h>

// 相棒が見つけた「座標の住所」
#define ENEMY_COORD_OFFSET 0x03A79000 

void (*old_update)(void *self);
void new_update(void *self) {
    // ここで座標を抜き取って、ESPの表示を更新するじょ！
    old_update(self);
}

%ctor {
    // GitHub Actionsでビルドされたdylibが、起動時にこの住所に罠を仕掛けるじょ
    MSHookFunction((void *)(_dyld_get_image_header(0) + ENEMY_COORD_OFFSET), 
                   (void *)&new_update, (void **)&old_update);
}
