const db = require('../../../db');
const tableNames = require('../../../constants/tableNames');

module.exports = {
  async getUserRacketsData(reqParams) {
    const userData = await db
      .select(
        'user.id',
        'user.nick',
        // 'user.thumb',
        'up.ntrp',
        'up.sex',
        'up.age',
        'up.weight_kg',
        'up.height_cm',
        'up.handed', {
          user_image: 'user.thumb',
          play_style: 'ps.name',
          forehand_style: 'fhs.name',
          backhand_style: 'bhs.name',
        }
      )
      .from({
        user: tableNames.user
      })
      .innerJoin({
        up: tableNames.userPhysical
      }, 'up.t_user_id', '=', 'user.id')
      .innerJoin({
        ps: tableNames.playStyle
      }, 'ps.id', '=', 'up.t_play_style_id')
      .innerJoin({
        fhs: tableNames.forehandStyle
      }, 'fhs.id', '=', 'up.t_forehand_style_id')
      .innerJoin({
        bhs: tableNames.backhandStyle
      }, 'bhs.id', '=', 'up.t_backhand_style_id')
      .where({

        'user.id': reqParams.t_user_id
      }).first();



    const racketHistoryData = await db
      .select(

        {
          user_racket_id: 'ur.id',
          racket_model: 'ra.model',
          racket_company_name: 'rc.name',
        },
      )
      .from({
        ur: tableNames.userRacket
      })
      .innerJoin({
        ra: tableNames.racketData
      }, 'ra.id', '=', 'ur.t_racket_id')
      .innerJoin({
          rc: tableNames.racketCompany
        },
        'rc.id',
        '=',
        'ra.t_racket_company_id'
      )

      .where({
        'ur.t_user_id': reqParams.t_user_id,
      });



    // const racketHistoryData = await db
    //   .select(
    //     'ur.id',
    //     'ur.t_racket_id',
    //     'urh.t_user_racket_id', {
    //       racket_vertion: 'rv.name',
    //       racket_model: 'ra.model',
    //       // gut_company_name: 'gutc.name',
    //       gut_name: 'urh.name',
    //     },
    //     'urh.id',
    //     'urh.weight_tune',
    //     'urh.overgrip_num',
    //     'urh.replacement_grip_type'
    //   )
    //   .from({
    //     ur: tableNames.userRacket
    //   })
    //   .innerJoin({
    //     ra: tableNames.racket
    //   }, 'ra.id', '=', 'ur.t_racket_id')
    //   .innerJoin({
    //       rv: tableNames.racketVersion
    //     },
    //     'rv.id',
    //     '=',
    //     'ra.t_racket_version_id'
    //   ).leftJoin({
    //       urh: db.raw('(select urhh.*, gut.name from test_tennist.t_user_racket_history urhh inner join test_tennist.t_gut gut on gut.id = urhh.t_gut_id order by created_at desc limit 1)')

    //     },
    //     'urh.t_user_racket_id', '=', 'ur.id'

    //   )
    //   .where({
    //     'ur.t_user_id': reqParams.t_user_id,
    //   });






    return {
      user_data: userData,
      list: racketHistoryData

    };
  },

};