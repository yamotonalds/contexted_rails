# 装備コンテキスト
# ちゃんと覚えてないのでテキトー
# Dressingコンテキストを見てなかったら先にそちらを見てね
# このコンテキスト内ではDressingとか別コンテキストのことをなーんも知らなくていい
module Equipment

  # キャラクター
  # Dressingコンテキストではアバターモデルがそのコンテキストでのキャラクターモデルだったが
  # 適切な名前が無さそうならここのようにそのまま Character という名前でも良い
  # あくまでもこのコンテキストで関心を持つキャラクターの側面がモデル化されていればOK
  class Character < ActiveRecord::Base
    # 核となるキャラクター(::Character)への参照を持つパティーン
    # メリット（まあだいたいSTIのデメリットが無い感じ）
    # - コンテキストごとにテーブルを持てるので、pluginっぽく新しいコンテキストの追加が楽（独立している）
    # デメリット
    # - 核となるキャラクター(::Character)が作成されても勝手にデータが作成されたりしない
    # - 核となるキャラクター(::Character)のID以外の情報にアクセスする場合はjoinとかselectが必要
    self.table_name = 'equipment_characters'
    belongs_to :character, class_name: '::Character'


    has_one :main_weapon, class_name: 'Equipment::Weapon', foreign_key: :equipment_character_id, autosave: true, dependent: :destroy
    has_many :weapons, class_name: 'Equipment::Weapon', foreign_key: :equipment_character_id, autosave: true, dependent: :destroy


    # 他のコンテキストに依存しないバリデーションが書ける
    validate :validate_weapon_cost

    class << self
      # 処理の起点となるアバターオブジェクト取得用メソッド
      # ドメインロジックにはARのような実装の詳細は晒すべきではない
      # FinderクラスやDDDのRepositoryクラスのように外出しされていても良い
      def get(character_id)
        find(character_id: character_id)
      end

      # 永続化用メソッド
      def persist
        save!
      end
    end

    # ドメインロジック
    def chage_main_weapon(weapon)
      fail 'weaponsのどれかである必要がある' unless weapon.in? weapons
      main_weapon = weapon
    end

    def set_weapon(slot_no, weapon)
      #
    end

    private

    def validate_weapon_cost
      # Equipmentコンテキストだけのバリデーション
      if weapons.map(&:cost).sum >= 100
        errors.add(:weapons, :invalid)
      end
    end
  end
end
