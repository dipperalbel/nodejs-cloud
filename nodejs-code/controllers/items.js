const path = require('path');
const Items = require('../models/items');

exports.index = function (req, res) {
    res.sendFile(path.resolve('views/items.html'));
};

exports.create = function (req, res) {
    var newItem = new Items(req.body);
    console.log(req.body);
    newItem.save(function (err) {
            if(err) {
            res.status(400).send('Unable to save item to database');
        } else {
            res.redirect('/items/getitems');
        }
  });
               };

exports.list = function (req, res) {
        Items.find({}).exec(function (err, items) {
                if (err) {
                        return res.send(500, err);
                }
                res.render('getitems', {
                        items: items
             });
        });
};
