import { Request, Response } from "express"
import { ListaAtividadesUseCase, ListaUserAtividadeNaoEntregueUseCase, ListaUserAtividadeUseCase } from "./ListaUserAtividadeUseCase"

export class ListaUserAtividadeController {
    async handle(req: Request, res: Response) {
        
        const listaUserAtividadeUseCase = new ListaUserAtividadeUseCase()
        const { id_aluno } = req.query
        
        const result = await listaUserAtividadeUseCase.execute(Number(id_aluno))
        return res.status(201).json(result)
    }
}

export class ListaUserAtividadeNaoEntregueController {
    async handle(req: Request, res: Response) {
        
        const listaUserAtividadeNaoEntregueUseCase = new ListaUserAtividadeNaoEntregueUseCase()
        const { id_aluno } = req.query
        
        const result = await listaUserAtividadeNaoEntregueUseCase.execute(Number(id_aluno))
        return res.status(201).json(result)
    }
}

export class ListaAtividadesController {
    async handle(req: Request, res: Response) {
        
        const listaAtividadesUseCase = new ListaAtividadesUseCase()
        const { id_atividade } = req.query
        
        const result = await listaAtividadesUseCase.execute(Number(id_atividade))
        return res.status(201).json(result)
    }
}