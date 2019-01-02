view: dimensionalizingameasure {

    sql_table_name: (SELECT
        products.id  AS `products.id`,
        COUNT(*) AS `products.count`
      FROM demo_db.products  AS products

      GROUP BY 1)
       ;;



  dimension: prim_key {
    type: number
    primary_key: yes
    sql: ${TABLE}.`products.id` ;;
    }

  measure: count {
    type: count
    drill_fields: [detail*]
  }


  dimension: products_count {
    type: number
    sql: ${TABLE}.`products.count` ;;
  }
  measure: average_value {
    type: average
    sql: ${products_count} ;;
  }

  set: detail {
    fields: [prim_key, products_count]
  }
}