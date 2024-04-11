import { Request, Response } from "express";
import { LeUserUseCase } from "./LeUserUseCase";

export class LeUserController {
    async handle(req: Request, res: Response) {
        
        const leUserUseCase = new LeUserUseCase();

        const { id } = req.query;
        
        const result = await leUserUseCase.execute(Number(id));
        return res.status(201).json(result);
    }
}