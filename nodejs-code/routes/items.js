const express = require('express');
const router = express.Router();
const item = require('../controllers/items');

router.get('/', function(req, res){
    item.index(req,res);
});

router.post('/additem', function(req, res) {
    item.create(req,res);
});

router.get('/getitems', function(req, res) {
    item.list(req,res);
});

module.exports = router;
