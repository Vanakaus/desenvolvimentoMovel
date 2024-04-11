import { Request, Response } from "express";
import { LeAtividadeUseCase } from "./LeAtividadeUseCase";

export class LeAtividadeController {
    async handle(req: Request, res: Response) {
        
        const leAtividadeUseCase = new LeAtividadeUseCase();

        const { id } = req.query;
        
        const result = await leAtividadeUseCase.execute(Number(id));
        return res.status(201).json(result);
    }
}