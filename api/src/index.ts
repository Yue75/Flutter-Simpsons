import bodyParser from "body-parser";
import cors from "cors";
import express, { Express } from "express";
import actualiteRouter from "./routes/actualite";
import episodeRouterGet from "./routes/episode";
import personnageRouterGet from "./routes/personnage";
import saisonsRouterGet from "./routes/saisons";
import userRouter from "./routes/user";

const app: Express = express();
const port = process.env.PORT || 3030;

app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Routes
app.use("/saisons", saisonsRouterGet);
app.use("/personnages", personnageRouterGet);
app.use("/episodes", episodeRouterGet);
app.use("/actualites", actualiteRouter);
app.use("/users", userRouter);

app.listen(port, () => {
  console.log(`⚡️[server]: Server is running at http://localhost:${port}`);
});
