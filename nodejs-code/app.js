const express = require('express');
const app = express();
const router = express.Router();
const db = require('./db');
const items = require('./routes/items');

const path = __dirname + '/views/';
const port = process.env.PORT || 8080;

app.engine('html', require('ejs').renderFile);
app.set('view engine', 'html');
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path));
app.use('/items', items);

app.get('/health',(req,res)=> {
  res.send ("Health check passed");
});

const server = app.listen(port, () => {
  console.log(`Example app listening on ${port}!`)
})

function cleanup () {
  server.close()
  .then(() => db.mongoose.close())
  .then(() => process.exit(0))
  .catch((err) => process.exit(-1))
}


process.on('SIGINT', cleanup);
process.on('SIGTERM', cleanup);
