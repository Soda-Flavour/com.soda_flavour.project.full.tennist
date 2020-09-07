/* eslint-disable function-paren-newline */
/* eslint-disable comma-dangle */
/* eslint-disable implicit-arrow-linebreak */
/* eslint-disable no-shadow */
/* eslint-disable no-unused-vars */
/* eslint-disable no-unused-vars */
const Knex = require('knex');
const {
  addDefaultColumns,
  createNameTable,
  url,
  email,
  references,
} = require('../../src/lib/tableUtils');
const tableNames = require('../../src/constants/tableNames');

exports.up = async (knex) => {
  await Promise.all([
    knex.schema.createTable(tableNames.userRacketHistory, (table) => {
      table.increments('id').notNullable();
      references(table, tableNames.user);
      references(table, tableNames.userRacket);
      references(table, tableNames.replacementGrip, false);
      references(table, tableNames.racketbalance);
      references(table, tableNames.gut);
      references(table, tableNames.gutTension, false, 'cross_gut_tension');
      references(table, tableNames.gutTension, false, 'main_gut_tension');
      table.integer('weight_tune').unsigned();
      table.string('replacement_grip_type').notNullable();
      table.integer('overgrip_num').unsigned();
      table.specificType('racket_balance_type', 'char(2)');
      table.float('racket_balance_val', 4).unsigned();
      table.float('main_gut_lb_tension', 4).unsigned();
      table.float('cross_gut_lb_tension', 4).unsigned();
      addDefaultColumns(table);
    }),
  ]);
};

exports.down = async (knex) => {
  await Promise.all(
    [tableNames.userRacketHistory].map((tablename) =>
      knex.schema.dropTableIfExists(tablename)
    )
  );
};
