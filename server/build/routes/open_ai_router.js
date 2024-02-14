"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const express_1 = require("express");
const generate_open_ai_1 = require("../controller/generate_open_ai");
const openAiRouter = (0, express_1.Router)();
openAiRouter.post("/", generate_open_ai_1.generateOpenAIResposeController);
exports.default = openAiRouter;
