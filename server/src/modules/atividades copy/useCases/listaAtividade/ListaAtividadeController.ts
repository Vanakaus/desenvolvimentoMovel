import { Request, Response } from "express"
import { ListaAtividadeUseCase } from "./ListaAtividadeUseCase"

export class ListaAtividadeController {
    async handle(req: Request, res: Response) {
        
        const listUserUseCase = new ListaAtividadeUseCase()
        
        const result = await listUserUseCase.execute()
        return res.status(201).json(result)
    }
}