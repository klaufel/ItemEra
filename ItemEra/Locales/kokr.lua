local L = LibStub("AceLocale-3.0"):NewLocale("ItemEra", "koKR")
if not L then return end

L["SELECT_EXPANSION"] = "확장팩 선택"
L["ALL_EXPANSION"] = "모든 확장팩"
L["EXPANSION"] = "확장팩:"
L["PROFESSION"] = "전문 기술:"

L["SETTINGS_MAIN_DESCRIPTION"] = "아이템에 확장팩 정보를 표시하고 필터링합니다."
L["SETTINGS_SUBPAGE_TOOLTIP"] = "툴팁"
L["SETTINGS_SUBPAGE_FILTERS"] = "필터"

L["SETTINGS_TOOLTIP_HEADER_NAME"] = "확장팩 표시"
L["SETTINGS_TOOLTIP_DESCRIPTION_NAME"] = "ItemEra 툴팁 표시 옵션을 설정합니다."

L["SETTINGS_SHOW_EXPANSION_LITERAL_NAME"] = "'확장팩' 글자 표시"
L["SETTINGS_SHOW_EXPANSION_LITERAL_DESC"] = "툴팁에서 이름과 로고 앞에 '확장팩' 글자를 표시합니다"

L["SETTINGS_SHOW_EXPANSION_NAME_NAME"] = "확장팩 이름"
L["SETTINGS_SHOW_EXPANSION_NAME_DESC"] = "툴팁 아이콘 옆에 확장팩 이름을 표시합니다"

L["SETTINGS_SHOW_EXPANSION_LOGO_NAME"] = "확장팩 로고"
L["SETTINGS_SHOW_EXPANSION_LOGO_DESC"] = "툴팁 아이콘 옆에 확장팩 로고를 표시합니다"

L["SETTINGS_PROFESSION_HEADER_NAME"] = "전문 기술 표시"
L["SETTINGS_PROFESSION_DESCRIPTION_NAME"] = "제작 시약 툴팁에 전문 기술 표시 옵션을 설정합니다."

L["SETTINGS_SHOW_PROFESSION_LITERAL_NAME"] = "'전문 기술' 글자 표시"
L["SETTINGS_SHOW_PROFESSION_LITERAL_DESC"] = "툴팁에서 이름과 아이콘 앞에 '전문 기술' 글자를 표시합니다"

L["SETTINGS_SHOW_PROFESSION_NAME_NAME"] = "전문 기술 이름"
L["SETTINGS_SHOW_PROFESSION_NAME_DESC"] = "툴팁에 전문 기술 이름을 표시합니다"

L["SETTINGS_SHOW_PROFESSION_ICON_NAME"] = "전문 기술 아이콘"
L["SETTINGS_SHOW_PROFESSION_ICON_DESC"] = "툴팁에 전문 기술 아이콘을 표시합니다"

L["SETTINGS_WRAP_PROFESSION_TEXT_NAME"] = "전문 기술 텍스트 줄바꿈"
L["SETTINGS_WRAP_PROFESSION_TEXT_DESC"] = "텍스트가 길 경우 여러 줄로 줄바꿈합니다"

L["SETTINGS_TOOLTIP_PREVIEW_HIDDEN"] = "(툴팁이 표시되지 않습니다)"
L["SETTINGS_TOOLTIP_PREVIEW_NAME"] = "툴팁 미리보기:"

L["SETTINGS_KEY_MODIFIER_HEADER_NAME"] = "키 수정자"

L["SETTINGS_USE_KEY_MODIFIER_NAME"] = "키 수정자 사용"
L["SETTINGS_USE_KEY_MODIFIER_DESC"] = "수정 키를 누를 때만 확장팩 정보를 표시합니다."

L["SETTINGS_KEY_MODIFIER_NAME"] = "수정 키"
L["SETTINGS_KEY_MODIFIER_DESC"] = "확장팩 정보를 표시할 때 사용할 수정 키를 선택합니다."

L["SETTINGS_FILTERS_HEADER_NAME"] = "확장팩 필터"
L["SETTINGS_FILTERS_DESCRIPTION_NAME"] = "게임 창에서 확장팩 필터를 활성화하거나 비활성화합니다."

L["SETTINGS_FILTERS_INVENTORY_NAME"] = "인벤토리"
L["SETTINGS_FILTERS_INVENTORY_DESC"] = "인벤토리 가방에서 확장팩 필터를 활성화합니다"

L["SETTINGS_FILTERS_BANK_NAME"] = "개인 은행"
L["SETTINGS_FILTERS_BANK_DESC"] = "개인 은행에서 확장팩 필터를 활성화합니다"

L["SETTINGS_FILTERS_GUILD_BANK_NAME"] = "길드 은행"
L["SETTINGS_FILTERS_GUILD_BANK_DESC"] = "길드 은행에서 확장팩 필터를 활성화합니다"

L["SETTINGS_RELOAD_REQUIRED"] = "필터 변경 사항을 적용하려면 인터페이스를 (/reload) 다시 불러와야 합니다."
L["SETTINGS_RELOAD_POPUP_TEXT"] = "필터 변경 사항을 적용하려면 인터페이스를 다시 불러와야 합니다."
L["SETTINGS_RELOAD_POPUP_BUTTON1"] = "지금 다시 불러오기"
L["SETTINGS_RELOAD_POPUP_BUTTON2"] = "나중에"
L["SETTINGS_RESET_NAME"] = "기본 설정"
L["SETTINGS_RESET_DESC"] = "모든 설정을 기본값으로 초기화합니다"

L["SETTINGS_DISCORD_NAME"] = "디스코드 참여"
L["SETTINGS_DISCORD_DESC"] = "지원 및 업데이트를 위해 디스코드 커뮤니티에 참여하세요"
L["SETTINGS_DISCORD_POPUP_TEXT"] = "디스코드에 참여하려면 이 링크를 복사하세요:"

L["SETTINGS_FEATURES_POPUP_NAME"] = "새로운 기능"
L["SETTINGS_FEATURES_POPUP_DESC"] = "이 버전의 새로운 기능을 확인합니다"

L["SETTINGS_DECORATIONS_HEADER_NAME"] = "아이템 장식"
L["SETTINGS_DECORATIONS_DESCRIPTION_NAME"] = "인벤토리 아이템에 확장팩 아이콘을 표시합니다."
L["SETTINGS_DECORATIONS_ENABLED_NAME"] = "아이템 장식 활성화"
L["SETTINGS_DECORATIONS_ENABLED_DESC"] = "가방의 각 아이템에 작은 확장팩 아이콘을 표시합니다. 아이콘에 마우스를 올리면 확장팩 이름이 표시됩니다."

L["SETTINGS_BAGANATOR_HEADER_NAME"] = "Baganator 연동"
L["SETTINGS_BAGANATOR_DETECTED"] = "Baganator 감지됨!"
L["SETTINGS_BAGANATOR_NOT_DETECTED"] = "Baganator 감지되지 않음."
L["SETTINGS_BAGANATOR_DESCRIPTION_ACTIVE"] = "ItemEra가 Baganator 아이템 모서리에 확장팩 아이콘을 추가합니다. Baganator가 활성화되면 기본 필터는 비활성화됩니다."
L["SETTINGS_BAGANATOR_DESCRIPTION_INACTIVE"] = "Baganator를 설치하면 확장팩 카테고리 연동을 사용할 수 있습니다."
L["SETTINGS_BAGANATOR_ENABLED_NAME"] = "Baganator 연동 활성화"
L["SETTINGS_BAGANATOR_ENABLED_DESC"] = "Baganator 사용 시 아이템에 확장팩 아이콘을 표시합니다"

L["SETTINGS_BAGNON_HEADER_NAME"] = "Bagnon 연동"
L["SETTINGS_BAGNON_DETECTED"] = "Bagnon 감지됨!"
L["SETTINGS_BAGNON_NOT_DETECTED"] = "Bagnon 감지되지 않음."
L["SETTINGS_BAGNON_DESCRIPTION_ACTIVE"] = "ItemEra가 Bagnon에 확장팩 필터를 추가합니다. Bagnon이 활성화되면 기본 필터는 비활성화됩니다."
L["SETTINGS_BAGNON_DESCRIPTION_INACTIVE"] = "Bagnon을 설치하면 확장팩 필터 연동을 사용할 수 있습니다."
L["SETTINGS_BAGNON_ENABLED_NAME"] = "Bagnon 연동 활성화"
L["SETTINGS_BAGNON_ENABLED_DESC"] = "Bagnon 사용 시 확장팩 필터 드롭다운을 표시합니다"

L["SETTINGS_SUBPAGE_ADVANCED"] = "고급"
L["SETTINGS_API_HOOK_HEADER_NAME"] = "API 오버라이드"
L["SETTINGS_API_HOOK_DESCRIPTION"] = "게임의 C_Item.GetItemInfo 함수를 오버라이드하여 모든 애드온이 ItemEra의 수정된 확장팩 ID를 받도록 합니다."
L["SETTINGS_API_HOOK_WARNING"] = "경고: 이는 핵심 게임 함수를 수정하는 실험적 기능입니다. 다른 애드온과 호환성 문제가 발생할 수 있습니다. 사용 시 주의하세요."
L["SETTINGS_API_HOOK_ENABLED_NAME"] = "API 오버라이드 활성화"
L["SETTINGS_API_HOOK_ENABLED_DESC"] = "C_Item.GetItemInfo를 교체하여 전역적으로 ItemEra의 확장팩 ID를 반환합니다"

-- Features Popup
L["FEATURES_POPUP_TITLE"] = "새로운 기능"
L["FEATURES_POPUP_VERSION"] = "버전"
L["FEATURES_POPUP_CLOSE"] = "닫기"
L["FEATURES_POPUP_DONT_SHOW_AGAIN"] = "이 버전에서는 다시 표시하지 않음"

-- 추가 번역 (혹시 빠진 부분이 있을 경우)
L["SETTINGS_FEATURES_POPUP_NAME"] = "새로운 기능"
L["SETTINGS_FEATURES_POPUP_DESC"] = "이 버전의 새로운 기능을 확인합니다"
L["FEATURES_POPUP_CONTENT"] = [[
|cff00ff00안녕하세요! 이번 버전의 새로운 기능은 다음과 같습니다.|r

|cffffd700제작 시약|r
이제 툴팁에 각 시약을 사용하는 전문 기술이 표시됩니다. 모든 게임 내 제작법을 기반으로 하며 해당 전문 기술과 연결됩니다. 시약 등급 지원을 포함해 데이터베이스가 업데이트되었습니다.

전문 기술 표시 방식은 아이콘+이름, 이름만, 아이콘만으로 자유롭게 설정할 수 있습니다.

|cffffd700이전 버전에서 추가된 기능:|r
- Baganator 및 Bagnon 필터 지원 (내부 검색 사용)
- 완전히 새로 디자인된 "설정" 섹션에서 더 많은 구성 옵션 제공

ItemEra를 사용해 주셔서 감사합니다!
]]
