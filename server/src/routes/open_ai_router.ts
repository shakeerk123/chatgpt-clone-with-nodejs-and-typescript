import { Router, Request, Response } from "express";
import { generateOpenAIResposeController } from "../controller/generate_open_ai";
const openAiRouter = Router()

openAiRouter.post("/", generateOpenAIResposeController);
export default openAiRouter