export interface newTicketInput {
  idUserReported: string;
  idSocial: string;
  category: string;
  description?: string;
  tags?: string;
  photos: [];
}
