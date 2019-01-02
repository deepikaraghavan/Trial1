view: products {
  sql_table_name: demo_db.products ;;

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: brand {
    type: string
    sql: ${TABLE}.brand ;;
    drill_fields: [id]
  }

  dimension: category {
    type: string
    sql: ${TABLE}.category ;;
  }

  dimension: department {
    type: string
    sql: ${TABLE}.department ;;
  }

  dimension: item_name {
    type: string
    sql: ${TABLE}.item_name ;;
  }

  dimension: rank {
    type: number
    sql: ${TABLE}.rank ;;
  }

  dimension: retail_price {
    type: number
    sql: ${TABLE}.retail_price ;;
  }

  dimension: sku {
    type: string
    sql: ${TABLE}.sku ;;
  }

  dimension: is_women {
    type: yesno
    sql: ${department}='Women' ;;
  }

dimension: price_tier {
  description: "tiers the different price levels"
  type: tier
  style: integer
  tiers: [0,15,30,75,150,300]
  sql: ${retail_price} ;;
}
  measure: count {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
  }
  measure: total_revenue {
    description: "total revenue"
    type: sum
    sql: ${retail_price} ;;
    value_format_name: usd
  }

  measure: count_women {
    type: count
    drill_fields: [id, item_name, inventory_items.count]
    filters: {
      field: department
      value: "women"
    }
  }
  parameter: sale_price_metric_picker {
    description: "Use with the Sale Price Metric measure"
    type: unquoted
#     allowed_value: {
#       label: "Total Sale Price"
#       value: "SUM"
#     }
#     allowed_value: {
#       label: "Average Sale Price"
#       value: "AVG"
#     }
#     allowed_value: {
#       label: "Maximum Sale Price"
#       value: "MAX"
#     }
#     allowed_value: {
#       label: "Minimum Sale Price"
#       value: "MIN"
#     }
  }

  measure: sale_price_metric {
    description: "Use with the Sale Price Metric Picker filter-only field"
    type: number
    label: "sale_price_metric_picker_deepika"
    sql: {% parameter sale_price_metric_picker %}(${retail_price}) ;;
    value_format_name: usd
  }

}
