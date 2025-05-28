import bodyParser from "body-parser";
import cors from "cors";
import express, { Express } from "express";

import saisonsRouterDelete from "./routes/delete/saisons";
import saisonsRouterGet from "./routes/get/saisons";
import saisonsRouterPost from "./routes/post/saisons";
import saisonsRouterUpdate from "./routes/update/saisons";

import episodeRouterGet from "./routes/get/episode";
import personnageRouterGet from "./routes/get/personnage";

const app: Express = express();
const port = process.env.PORT || 3030;

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Routes
app.use("/saisons", saisonsRouterGet);
app.use("/saisons", saisonsRouterPost);
app.use("/saisons", saisonsRouterDelete);
app.use("/saisons", saisonsRouterUpdate);

app.use("/personnages", personnageRouterGet);

app.use("/episodes", episodeRouterGet);

app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
});
