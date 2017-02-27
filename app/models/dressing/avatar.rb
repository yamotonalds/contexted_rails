# 着せ替え（見た目装備変更）コンテキスト
module Dressing

  # アバター
  # Dressingコンテキストにおいて中心となるクラス
  # ドメインロジックではキャラクターに対応するアバターを取得するところからロジックが始まる感じ
  class Avatar < ActiveRecord::Base
    # charactersテーブルを直接参照するパティーン
    # メリット
    # - キャラクターが作成されると自動的にアバターも取得できるようになる
    # - table_name書くだけなので使い始めるのは簡単
    # - charactersテーブル直なのでリレーションが無い分パフォーマンスは良い？
    # デメリット（STIとほぼ同じ）
    # - DBのNOT NULL制約とかが使えない
    # - 他のコンテキストとカラムがかち合う可能性がある
    # - コンテキストごとにselect書いとかないと余計なものまで取得する
    # - annotate_models使ってると他のコンテキストでのカラム追加でコメント更新されてうざい
    self.table_name = 'characters'

    # ドメインロジックから操作するときは Avatar#costumes で Costume の集合が取れることは知っていて良いが、
    # ARで実装していることに依存してはいけない。
    has_many :costumes, autosave: true, dependent: :destroy

    # 他のコンテキストに依存しないバリデーションが書ける
    validate :validate_costume

    class << self
      # 処理の起点となるアバターオブジェクト取得用メソッド
      # ドメインロジックにはARのような実装の詳細は晒すべきではない
      # FinderクラスやDDDのRepositoryクラスのように外出しされていても良い
      def get(character_id)
        find(character_id)
      end

      # 永続化用メソッド
      def persist
        save!
      end
    end

    # ドメインロジック
    def dress_up(costume)
      costumes << costume
    end

    private

    def validate_costume
      return if costumes.empty?

      # Dressingコンテキストだけのバリデーション
      unless costumes.first.item_id % 10 == 1
        errors.add(:costumes, :invalid)
      end
    end
  end
end
